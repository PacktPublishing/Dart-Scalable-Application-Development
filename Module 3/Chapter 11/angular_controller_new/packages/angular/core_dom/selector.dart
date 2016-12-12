part of angular.core.dom_internal;

/**
 * [DirectiveSelector] is used by the [Compiler] during the template walking to extract the
 * [DirectiveRef]s.
 *
 * [DirectiveSelector] can be created using the [DirectiveSelectorFactory].
 *
 * The DirectiveSelector supports CSS selectors which do not cross element boundaries only. The
 * selectors can have any mix of element-name, class-names and attribute-names.
 *
 * Examples:
 *
 *  * element
 *  * .class
 *  * [attribute]
 *  * [attribute=value]
 *  * [wildcard-*]
 *  * element[attribute1][attribute2=value]
 *  * :contains(/abc/)
 *  * [*=/abc/]
 */
class DirectiveSelector {
  static String BIND_PREFIX = "bind-";
  static int BIND_PREFIX_LENGTH = 5;

  ElementBinderFactory _binderFactory;
  DirectiveMap _directives;
  Interpolate _interpolate;
  FormatterMap _formatters;
  ASTParser _astParser;
  final Injector _injector;
  var elementSelector = new _ElementSelector('');
  var attrSelector = <_ContainsSelector>[];
  var textSelector = <_ContainsSelector>[];

  /// Parses all the [_directives] so they can be retrieved via [matchElement]
  DirectiveSelector(this._directives, this._formatters, this._binderFactory, this._interpolate,
      this._astParser, this._injector) {
    _directives.forEach((Directive annotation, Type type) {
      var match;
      var selector = annotation.selector;
      List<_SelectorPart> selectorParts;
      if (selector == null) {
        throw new ArgumentError('Missing selector annotation for $type');
      }

      if ((match = _CONTAINS_REGEXP.firstMatch(selector)) != null) {
        textSelector.add(new _ContainsSelector(selector, match[1]));
      } else if ((match = _ATTR_CONTAINS_REGEXP.firstMatch(selector)) != null) {
        attrSelector.add(new _ContainsSelector(selector, match[1]));
      } else if ((selectorParts = _splitCss(selector, type)) != null){
        elementSelector.addDirective(selectorParts, new _Directive(type, annotation));
      } else {
        throw new ArgumentError('Unsupported Selector: $selector');
      }
    });
  }

  /**
   * [matchElement] returns an [ElementBinder] or a [TemplateElementBinder] configured with all the
   * directives triggered by the `node`.
   */
  ElementBinder matchElement(dom.Node node) {
    assert(node is dom.Element);

    ElementBinderBuilder builder = _binderFactory.builder(_formatters, _directives, _injector);
    List<_ElementSelector> partialSelection;
    final classes = new Set<String>();
    final attrs = new HashMap<String, String>();

    dom.Element element = node;
    String nodeName = element.tagName.toLowerCase();

    // Set default attribute
    if (nodeName == 'input' && !element.attributes.containsKey('type')) {
      element.attributes['type'] = 'text';
    }

    // Select node
    partialSelection = elementSelector.selectNode(builder, partialSelection, element, nodeName);

    // Select .name
    for (var name in element.classes) {
      classes.add(name);
      partialSelection = elementSelector.selectClass(builder, partialSelection, element, name);
    }

    // Select [attributes]
    element.attributes.forEach((attrName, value) {

      if (attrName.startsWith("on-")) {
        builder.onEvents[attrName] = value;
      } else if (attrName.startsWith(BIND_PREFIX)) {
        builder.bindAttrs[attrName.substring(BIND_PREFIX_LENGTH)] =
            _astParser(value, formatters: _formatters);
      }

      attrs[attrName] = value;
      for (var k = 0; k < attrSelector.length; k++) {
        _ContainsSelector selectorRegExp = attrSelector[k];
        if (selectorRegExp.regexp.hasMatch(value)) {
          // this directive is matched on any attribute name, and so
          // we need to pass the name to the directive by prefixing it to
          // the value. Yes it is a bit of a hack.
          _directives[selectorRegExp.selector].forEach((DirectiveTypeTuple tuple) {
            // Pre-compute the AST to watch this value.
            Interpolation interpolation = _interpolate(value);
            AST valueAST = _astParser(interpolation.expression, formatters: _formatters);
            builder.addDirective(new DirectiveRef(
                node, tuple.type, tuple.directive, new Key(tuple.type), attrName, valueAST, interpolation.bindingExpressions));
          });
        }
      }

      partialSelection = elementSelector.selectAttr(builder,
          partialSelection, node, attrName, value);
    });

    while (partialSelection != null) {
      List<_ElementSelector> elementSelectors = partialSelection;
      partialSelection = null;
      elementSelectors.forEach((_ElementSelector elementSelector) {
        classes.forEach((className) {
          partialSelection = elementSelector.selectClass(builder,
              partialSelection, node, className);
        });
        attrs.forEach((attrName, value) {
          partialSelection = elementSelector.selectAttr(builder,
              partialSelection, node, attrName, value);
        });
      });
    }
    return builder.binder;
  }

  ElementBinder matchText(dom.Node node) {
    ElementBinderBuilder builder = _binderFactory.builder(_formatters, _directives, _injector);

    var value = node.nodeValue;
    for (var k = 0; k < textSelector.length; k++) {
      var selectorRegExp = textSelector[k];
      if (selectorRegExp.regexp.hasMatch(value)) {
        _directives[selectorRegExp.selector].forEach((tuple) {
          // Pre-compute the AST to watch this value.
          Interpolation interpolation = _interpolate(value);
          var valueAST = _astParser(interpolation.expression, formatters: _formatters);

          builder.addDirective(new DirectiveRef(node, tuple.type,
              tuple.directive, new Key(tuple.type), value, valueAST, interpolation.bindingExpressions));
        });
      }
    }
    return builder.binder;
  }

  ElementBinder matchComment(dom.Node node) => _binderFactory.builder(null, null, _injector).binder;
}

/**
 * Factory for creating a [DirectiveSelector].
 */
@Injectable()
class DirectiveSelectorFactory {
  ElementBinderFactory _binderFactory;
  Interpolate _interpolate;
  ASTParser _astParser;
  // TODO(deboer): Remove once the FormatterMap is a required 'selector' parameter.
  FormatterMap _defaultFormatterMap;

  // TODO(rkirov): Remove once the injector is a required 'selector' parameter.
  Injector _defaultInjector;

  DirectiveSelectorFactory(this._binderFactory, this._interpolate,
                           this._astParser, this._defaultFormatterMap, this._defaultInjector);

  /**
   * Create a new [DirectiveSelector] given a [DirectiveMap] and [FormatterMap]
   *
   * NOTE: [injector and formatters] will become required very soon.  New code must pass
   * both parameters.
   */
  DirectiveSelector selector(DirectiveMap directives, [Injector injector, FormatterMap formatters]) =>
      new DirectiveSelector(directives,
          formatters != null ? formatters : _defaultFormatterMap,
          _binderFactory, _interpolate, _astParser,
          injector != null ? injector : _defaultInjector);
}

class _Directive {
  final Type type;
  final Directive annotation;

  _Directive(this.type, this.annotation);

  String toString() => annotation.selector;
}

class _ContainsSelector {
  final String selector;
  final RegExp regexp;

  _ContainsSelector(this.selector, String regexp)
      : regexp = new RegExp(regexp);
}

final _SELECTOR_REGEXP = new RegExp(
    r'^(?:([-\w]+)|'                      // "tag"
    r'(?:\.([-\w]+))|'                    // ".class"
    r'(?:\[([-\w*]+)(?:=([^\]]*))?\]))'); // "[name]", "[name=value]" or "[name*=value]"
final _CONTAINS_REGEXP = new RegExp(r'^:contains\(\/(.+)\/\)$'); // ":contains(/text/)"
final _ATTR_CONTAINS_REGEXP = new RegExp(r'^\[\*=\/(.+)\/\]$');  // "[*=/value/]

class _SelectorPart {
  final String element;
  final String className;
  final String attrName;
  final String attrValue;

  const _SelectorPart.fromElement(this.element)
      : className = null, attrName = null, attrValue = null;

  const _SelectorPart.fromClass(this.className)
      : element = null, attrName = null, attrValue = null;

  const _SelectorPart.fromAttribute(this.attrName, this.attrValue)
      : element = null, className = null;

  String toString() =>
    element == null
      ? (className == null
         ? (attrValue == '' ? '[$attrName]' : '[$attrName=$attrValue]')
         : '.$className')
      : element;
}

_addRefs(ElementBinderBuilder builder, List<_Directive> directives, dom.Node node,
         [String attrValue]) {
  directives.forEach((directive) {
    builder.addDirective(new DirectiveRef(node, directive.type, directive.annotation, new Key(directive.type), attrValue));
  });
}

class _ElementSelector {
  final String _name;

  final _elementMap = new HashMap<String, List<_Directive>>();
  final _elementPartialMap = new HashMap<String, _ElementSelector>();

  final _classMap = new HashMap<String, List<_Directive>>();
  final _classPartialMap = new HashMap<String, _ElementSelector>();

  final _attrValueMap = new HashMap<String, Map<String, List<_Directive>>>();
  final _attrValuePartialMap = new HashMap<String, Map<String, _ElementSelector>>();

  _ElementSelector(this._name);

  void addDirective(List<_SelectorPart> selectorParts, _Directive directive) {
    assert(selectorParts.isNotEmpty);
    var elSelector = this;
    var name;
    for (var i = 0; i < selectorParts.length; i++) {
      var part = selectorParts[i];
      var terminal = i == selectorParts.length - 1;
      if ((name = part.element) != null) {
        if (terminal) {
          elSelector._elementMap.putIfAbsent(name, () => []).add(directive);
        } else {
          elSelector = elSelector._elementPartialMap
              .putIfAbsent(name, () => new _ElementSelector(name));
        }
      } else if ((name = part.className) != null) {
        if (terminal) {
          elSelector._classMap.putIfAbsent(name, () => []).add(directive);
        } else {
          elSelector = elSelector._classPartialMap
              .putIfAbsent(name, () => new _ElementSelector(name));
        }
      } else if ((name = part.attrName) != null) {
        if (terminal) {
          elSelector._attrValueMap.putIfAbsent(name, () => new HashMap<String, List<_Directive>>())
              .putIfAbsent(part.attrValue, () => [])
              .add(directive);
        } else {
          elSelector = elSelector._attrValuePartialMap
              .putIfAbsent(name, () => new HashMap<String, _ElementSelector>())
              .putIfAbsent(part.attrValue, () => new _ElementSelector(name));
        }
      } else {
        throw "Unknown selector part '$part'.";
      }
    }
  }

  List<_ElementSelector> selectNode(ElementBinderBuilder builder,
                                    List<_ElementSelector> partialSelection,
                                    dom.Node node, String nodeName) {
    if (_elementMap.containsKey(nodeName)) {
      _addRefs(builder, _elementMap[nodeName], node);
    }
    if (_elementPartialMap.containsKey(nodeName)) {
      if (partialSelection == null) {
        partialSelection = new List<_ElementSelector>();
      }
      partialSelection.add(_elementPartialMap[nodeName]);
    }
    return partialSelection;
  }

  List<_ElementSelector> selectClass(ElementBinderBuilder builder,
                                     List<_ElementSelector> partialSelection,
                                     dom.Node node, String className) {
    if (_classMap.containsKey(className)) {
      _addRefs(builder, _classMap[className], node);
    }
    if (_classPartialMap.containsKey(className)) {
      if (partialSelection == null) {
        partialSelection = new List<_ElementSelector>();
      }
      partialSelection.add(_classPartialMap[className]);
    }
    return partialSelection;
  }

  List<_ElementSelector> selectAttr(ElementBinderBuilder builder,
                                    List<_ElementSelector> partialSelection,
                                    dom.Node node, String attrName,
                                    String attrValue) {

    String matchingKey = _matchingKey(_attrValueMap.keys, attrName);

    if (matchingKey != null) {
      Map<String, List<_Directive>> valuesMap = _attrValueMap[matchingKey];
      if (valuesMap.containsKey('')) {
        _addRefs(builder, valuesMap[''], node, attrValue);
      }
      if (attrValue != '' && valuesMap.containsKey(attrValue)) {
        _addRefs(builder, valuesMap[attrValue], node, attrValue);
      }
    }
    if (_attrValuePartialMap.containsKey(attrName)) {
      Map<String, _ElementSelector> valuesPartialMap =
          _attrValuePartialMap[attrName];
      if (valuesPartialMap.containsKey('')) {
        if (partialSelection == null) {
          partialSelection = new List<_ElementSelector>();
        }
        partialSelection.add(valuesPartialMap['']);
      }
      if (attrValue != '' && valuesPartialMap.containsKey(attrValue)) {
        if (partialSelection == null) {
            partialSelection = new List<_ElementSelector>();
        }
        partialSelection.add(valuesPartialMap[attrValue]);
      }
    }
    return partialSelection;
  }

  // A global cache for the _matchingKey RegExps.  The size is bounded by
  // the number of attribute directive selectors used in the application.
  static var _matchingKeyCache = new HashMap<String, RegExp>();

  String _matchingKey(Iterable<String> keys, String attrName) =>
      keys.firstWhere((key) =>
          _matchingKeyCache.putIfAbsent(key,
                  () => new RegExp('^${key.replaceAll('*', r'[-\w]+')}\$'))
              .hasMatch(attrName), orElse: () => null);

  String toString() => 'ElementSelector($_name)';
}

/**
 * Turn a CSS selector string into a list of [_SelectorPart]s
 */
List<_SelectorPart> _splitCss(String selector, Type type) {
  var parts = <_SelectorPart>[];
  var remainder = selector;
  var match;
  while (remainder.isNotEmpty) {
    if ((match = _SELECTOR_REGEXP.firstMatch(remainder)) != null) {
      if (match[1] != null) {
        parts.add(new _SelectorPart.fromElement(match[1].toLowerCase()));
      } else if (match[2] != null) {
        parts.add(new _SelectorPart.fromClass(match[2].toLowerCase()));
      } else if (match[3] != null) {
        var attrValue = match[4] == null ? '' : match[4].toLowerCase();
        parts.add(new _SelectorPart.fromAttribute(match[3].toLowerCase(),
                                                  attrValue));
      } else {
        throw "Missmatched RegExp $_SELECTOR_REGEXP on $remainder";
      }
    } else {
      throw "Unknown selector format '$selector' for $type.";
    }
    remainder = remainder.substring(match.end);
  }
  return parts;
}
