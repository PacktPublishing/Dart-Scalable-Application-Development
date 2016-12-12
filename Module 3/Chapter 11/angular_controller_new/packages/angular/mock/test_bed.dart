part of angular.mock;

/**
 * Class which simplifies bootstraping of angular for unit tests.
 *
 * Simply inject [TestBed] into the test, then use [compile] to
 * match directives against the view.
 */
class TestBed {
  final Injector injector;
  final Scope rootScope;
  final Compiler compiler;
  final Parser _parser;
  final Expando expando;

  Element rootElement;
  List<Node> rootElements;
  View rootView;

  TestBed(this.injector, this.rootScope, this.compiler, this._parser, this.expando);

  TestBed.fromInjector(Injector i) :
    this(i, i.get(RootScope), i.get(Compiler), i.get(Parser), i.get(Expando));


  /**
   * Use to compile HTML and activate its directives.
   *
   * If [html] parameter is:
   *
   *   - [String] then treat it as HTML
   *   - [Node] then treat it as the root node
   *   - [List<Node>] then treat it as a collection of nods
   *
   * After the compilation the [rootElements] contains an array of compiled root nodes,
   * and [rootElement] contains the first element from the [rootElemets].
   *
   * An option [scope] parameter can be supplied to link it with non root scope.
   */
  Element compile(html, {Scope scope, DirectiveMap directives}) {
    if (scope == null) scope = rootScope;
    if (html is String) {
      rootElements = toNodeList(html);
    } else if (html is Node) {
      rootElements = [html];
    } else if (html is List<Node>) {
      rootElements = html;
    } else {
      throw 'Expecting: String, Node, or List<Node> got $html.';
    }
    rootElement = rootElements.length > 0 && rootElements[0] is Element ? rootElements[0] : null;
    if (directives == null) {
      directives = injector.getByKey(DIRECTIVE_MAP_KEY);
    }
    rootView = compiler(rootElements, directives)(scope, null, rootElements);
    return rootElement;
  }

  /**
   * Convert an [html] String to a [List] of [Element]s.
   */
  List<Element> toNodeList(html) {
    var div = new DivElement();
    var sanitizedHtml = _handleWhitespace(html);
    div.setInnerHtml(sanitizedHtml, treeSanitizer: new NullTreeSanitizer());
    var nodes = [];
    for (var node in div.nodes) {
      nodes.add(node);
    }
    return nodes;
  }

  /**
   * Trigger a specific DOM element on a given node to test directives
   * which listen to events.
   */
  triggerEvent(element, name, [type='MouseEvent']) {
    element.dispatchEvent(new Event.eventType(type, name));
    // Since we are manually triggering event we need to simulate apply();
    rootScope.apply();
  }

  /**
   * Select an [OPTION] in a [SELECT] with a given name and trigger the
   * appropriate DOM event. Used when testing [SELECT] controlls in forms.
   */
  selectOption(element, text) {
    element.querySelectorAll('option').forEach((o) => o.selected = o.text == text);
    triggerEvent(element, 'change');
    rootScope.apply();
  }

  ElementProbe getProbe(Node node) {
    while (node != null) {
      ElementProbe probe = expando[node];
      if (probe != null) return probe;
      node = node.parent;
    }
    throw 'Probe not found.';
  }

  Scope getScope(Node node) => getProbe(node).scope;

  String _handleWhitespace(html) {
    return html.split('\n')
               .map((line) {
                 var trimmed = line.trim();
                 return trimmed + (trimmed.isEmpty || trimmed.endsWith('>') ? '' : ' ');})
               .join();
  }
}
