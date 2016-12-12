part of angular.core.dom_internal;

abstract class ComponentFactory {
  BoundComponentFactory bind(DirectiveRef ref, directives);
}

/**
 * A Component factory with has been bound to a specific component type.
 */
abstract class BoundComponentFactory {
  List<Key> get callArgs;
  Function call(dom.Element element);

  static async.Future<ViewFactory> _viewFuture(
        Component component, ViewCache viewCache, DirectiveMap directives) {
    if (component.template != null) {
      return new async.Future.value(viewCache.fromHtml(component.template, directives));
    }
    if (component.templateUrl != null) {
      return viewCache.fromUrl(component.templateUrl, directives);
    }
    return null;
  }

  static void _setupOnShadowDomAttach(controller, TemplateLoader templateLoader,
                                      Scope shadowScope) {
    if (controller is ShadowRootAware) {
      templateLoader.template.then((shadowDom) {
        if (!shadowScope.isAttached) return;
        (controller as ShadowRootAware).onShadowRoot(shadowDom);
      });
    }
  }
}

@Injectable()
class ShadowDomComponentFactory implements ComponentFactory {
  final ViewCache viewCache;
  final Http http;
  final TemplateCache templateCache;
  final WebPlatform platform;
  final ComponentCssRewriter componentCssRewriter;
  final dom.NodeTreeSanitizer treeSanitizer;
  final Expando expando;
  final CompilerConfig config;

  final Map<_ComponentAssetKey, async.Future<dom.StyleElement>> styleElementCache = {};

  ShadowDomComponentFactory(this.viewCache, this.http, this.templateCache, this.platform,
                            this.componentCssRewriter, this.treeSanitizer, this.expando,
                            this.config, CacheRegister cacheRegister) {
    cacheRegister.registerCache("ShadowDomComponentFactoryStyles", styleElementCache);
  }

  bind(DirectiveRef ref, directives) =>
      new BoundShadowDomComponentFactory(this, ref, directives);
}

class BoundShadowDomComponentFactory implements BoundComponentFactory {

  final ShadowDomComponentFactory _f;
  final DirectiveRef _ref;
  final DirectiveMap _directives;

  Component get _component => _ref.annotation as Component;

  String _tag;
  async.Future<Iterable<dom.StyleElement>> _styleElementsFuture;
  async.Future<ViewFactory> _viewFuture;

  BoundShadowDomComponentFactory(this._f, this._ref, this._directives) {
    _tag = _component.selector.toLowerCase();
    _styleElementsFuture = async.Future.wait(_component.cssUrls.map(_styleFuture));

    _viewFuture = BoundComponentFactory._viewFuture(
        _component,
        new PlatformViewCache(_f.viewCache, _tag, _f.platform),
        _directives);
  }

  async.Future<dom.StyleElement> _styleFuture(cssUrl) {
    Http http = _f.http;
    TemplateCache templateCache = _f.templateCache;
    WebPlatform platform = _f.platform;
    ComponentCssRewriter componentCssRewriter = _f.componentCssRewriter;
    dom.NodeTreeSanitizer treeSanitizer = _f.treeSanitizer;

    return _f.styleElementCache.putIfAbsent(
        new _ComponentAssetKey(_tag, cssUrl), () =>
        http.get(cssUrl, cache: templateCache)
        .then((resp) => resp.responseText,
        onError: (e) => '/*\n$e\n*/\n')
        .then((String css) {

          // Shim CSS if required
          if (platform.cssShimRequired) {
            css = platform.shimCss(css, selector: _tag, cssUrl: cssUrl);
          }

          // If a css rewriter is installed, run the css through a rewriter
          var styleElement = new dom.StyleElement()
            ..appendText(componentCssRewriter(css, selector: _tag,
          cssUrl: cssUrl));

          // ensure there are no invalid tags or modifications
          treeSanitizer.sanitizeTree(styleElement);

          // If the css shim is required, it means that scoping does not
          // work, and adding the style to the head of the document is
          // preferrable.
          if (platform.cssShimRequired) {
            dom.document.head.append(styleElement);
            return null;
          }

          return styleElement;
        })
    );
  }

  List<Key> get callArgs => _CALL_ARGS;
  static final _CALL_ARGS = [DIRECTIVE_INJECTOR_KEY, SCOPE_KEY, NG_BASE_CSS_KEY,
                             EVENT_HANDLER_KEY];
  Function call(dom.Element element) {
    return (DirectiveInjector injector, Scope scope, NgBaseCss baseCss,
            EventHandler eventHandler) {
      var shadowDom = element.createShadowRoot()
        ..applyAuthorStyles = _component.applyAuthorStyles
        ..resetStyleInheritance = _component.resetStyleInheritance;

      var shadowScope = scope.createChild(new HashMap()); // Isolate

      async.Future<Iterable<dom.StyleElement>> cssFuture;
      if (_component.useNgBaseCss == true) {
        cssFuture = async.Future.wait(
                [async.Future.wait(baseCss.urls.map(_styleFuture)), _styleElementsFuture])
            .then((twoLists) {
              assert(twoLists.length == 2);
              return []..addAll(twoLists[0])..addAll(twoLists[1]);
            });
      } else {
        cssFuture = _styleElementsFuture;
      }

      ComponentDirectiveInjector shadowInjector;

      TemplateLoader templateLoader = new TemplateLoader(
          cssFuture.then((Iterable<dom.StyleElement> cssList) {
            cssList
              .where((styleElement) => styleElement != null)
              .forEach((styleElement) {
                shadowDom.append(styleElement.clone(true));
              });
            if (_viewFuture != null) {
              return _viewFuture.then((ViewFactory viewFactory) {
                if (shadowScope.isAttached) {
                  shadowDom.nodes.addAll(
                      viewFactory.call(shadowInjector.scope, shadowInjector).nodes);
                }
                return shadowDom;
              });
            }
            return shadowDom;
          }));

      var probe;
      shadowInjector = new ShadowDomComponentDirectiveInjector(injector, injector.appInjector,
          shadowScope, templateLoader, shadowDom);
      shadowInjector.bindByKey(_ref.typeKey, _ref.factory, _ref.paramKeys, _ref.annotation.visibility);

      if (_f.config.elementProbeEnabled) {
        probe = _f.expando[shadowDom] = shadowInjector.elementProbe;
        shadowScope.on(ScopeEvent.DESTROY).listen((ScopeEvent) => _f.expando[shadowDom] = null);
      }

      var controller = shadowInjector.getByKey(_ref.typeKey);
      BoundComponentFactory._setupOnShadowDomAttach(controller, templateLoader, shadowScope);
      shadowScope.context[_component.publishAs] = controller;

      return controller;
    };
  }
}

class _ComponentAssetKey {
  final String tag;
  final String assetUrl;

  final String _key;

  _ComponentAssetKey(String tag, String assetUrl)
      : _key = "$tag|$assetUrl",
        this.tag = tag,
        this.assetUrl = assetUrl;

  @override
  String toString() => _key;

  @override
  int get hashCode => _key.hashCode;

  bool operator ==(key) =>
      key is _ComponentAssetKey
      && tag == key.tag
      && assetUrl == key.assetUrl;
}

@Injectable()
class ComponentCssRewriter {
  String call(String css, { String selector, String cssUrl} ) {
    return css;
  }
}
