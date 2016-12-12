library angular_view.web.angular_view.generated_metadata;

import 'package:angular/core/registry.dart' show MetadataExtractor;
import 'package:di/di.dart' show Module;

import 'package:angular/formatter/module_internal.dart' as import_0;
import 'package:angular/core/annotation_src.dart' as import_1;
import 'package:angular/directive/module.dart' as import_2;
import 'package:angular/core_dom/module_internal.dart' as import_3;
import 'package:angular_view/job_listing.dart' as import_4;
import 'package:angular/animate/module.dart' as import_5;
import 'package:angular/routing/module.dart' as import_6;
import 'package:angular_view/component/search_job_component.dart' as import_7;
import 'package:angular_view/salary/salary_component.dart' as import_8;
import 'package:angular_view/formatter/company_filter.dart' as import_9;
Module get metadataModule => new Module()
    ..bind(MetadataExtractor, toValue: new _StaticMetadataExtractor());

class _StaticMetadataExtractor implements MetadataExtractor {
  Iterable call(Type type) {
    var annotations = typeAnnotations[type];
    if (annotations != null) {
      return annotations;
    }
    return [];
  }
}

final Map<Type, Object> typeAnnotations = {
  import_0.Currency: const [
    const import_1.Formatter(name: 'currency'),
  ],
  import_0.Date: const [
    const import_1.Formatter(name: 'date'),
  ],
  import_0.Filter: const [
    const import_1.Formatter(name: 'filter'),
  ],
  import_0.Json: const [
    const import_1.Formatter(name: 'json'),
  ],
  import_0.LimitTo: const [
    const import_1.Formatter(name: 'limitTo'),
  ],
  import_0.Lowercase: const [
    const import_1.Formatter(name: 'lowercase'),
  ],
  import_0.Arrayify: const [
    const import_1.Formatter(name: 'arrayify'),
  ],
  import_0.Number: const [
    const import_1.Formatter(name: 'number'),
  ],
  import_0.OrderBy: const [
    const import_1.Formatter(name: 'orderBy'),
  ],
  import_0.Uppercase: const [
    const import_1.Formatter(name: 'uppercase'),
  ],
  import_0.Stringify: const [
    const import_1.Formatter(name: 'stringify'),
  ],
  import_2.AHref: const [
    const import_1.Decorator(selector: 'a[href]'),
  ],
  import_2.NgBaseCss: const [
    const import_1.Decorator(selector: '[ng-base-css]', visibility: import_1.Visibility.CHILDREN, map: const {'ng-base-css': '@urls'}),
  ],
  import_2.NgBind: const [
    const import_1.Decorator(selector: '[ng-bind]', map: const {'ng-bind': '=>value'}),
  ],
  import_2.NgBindHtml: const [
    const import_1.Decorator(selector: '[ng-bind-html]', map: const {'ng-bind-html': '=>value'}),
  ],
  import_2.NgBindTemplate: const [
    const import_1.Decorator(selector: '[ng-bind-template]', map: const {'ng-bind-template': '@bind'}),
  ],
  import_2.NgClass: const [
    const import_1.Decorator(selector: '[ng-class]', map: const {'ng-class': '@valueExpression'}, exportExpressionAttrs: const ['ng-class',]),
  ],
  import_2.NgClassOdd: const [
    const import_1.Decorator(selector: '[ng-class-odd]', map: const {'ng-class-odd': '@valueExpression'}, exportExpressionAttrs: const ['ng-class-odd',]),
  ],
  import_2.NgClassEven: const [
    const import_1.Decorator(selector: '[ng-class-even]', map: const {'ng-class-even': '@valueExpression'}, exportExpressionAttrs: const ['ng-class-even',]),
  ],
  import_2.NgEvent: const [
    const import_1.Decorator(selector: '[ng-abort]', map: const {'ng-abort': '&onAbort'}),
    const import_1.Decorator(selector: '[ng-beforecopy]', map: const {'ng-beforecopy': '&onBeforeCopy'}),
    const import_1.Decorator(selector: '[ng-beforecut]', map: const {'ng-beforecut': '&onBeforeCut'}),
    const import_1.Decorator(selector: '[ng-beforepaste]', map: const {'ng-beforepaste': '&onBeforePaste'}),
    const import_1.Decorator(selector: '[ng-blur]', map: const {'ng-blur': '&onBlur'}),
    const import_1.Decorator(selector: '[ng-change]', map: const {'ng-change': '&onChange'}),
    const import_1.Decorator(selector: '[ng-click]', map: const {'ng-click': '&onClick'}),
    const import_1.Decorator(selector: '[ng-contextmenu]', map: const {'ng-contextmenu': '&onContextMenu'}),
    const import_1.Decorator(selector: '[ng-copy]', map: const {'ng-copy': '&onCopy'}),
    const import_1.Decorator(selector: '[ng-cut]', map: const {'ng-cut': '&onCut'}),
    const import_1.Decorator(selector: '[ng-doubleclick]', map: const {'ng-doubleclick': '&onDoubleClick'}),
    const import_1.Decorator(selector: '[ng-drag]', map: const {'ng-drag': '&onDrag'}),
    const import_1.Decorator(selector: '[ng-dragend]', map: const {'ng-dragend': '&onDragEnd'}),
    const import_1.Decorator(selector: '[ng-dragenter]', map: const {'ng-dragenter': '&onDragEnter'}),
    const import_1.Decorator(selector: '[ng-dragleave]', map: const {'ng-dragleave': '&onDragLeave'}),
    const import_1.Decorator(selector: '[ng-dragover]', map: const {'ng-dragover': '&onDragOver'}),
    const import_1.Decorator(selector: '[ng-dragstart]', map: const {'ng-dragstart': '&onDragStart'}),
    const import_1.Decorator(selector: '[ng-drop]', map: const {'ng-drop': '&onDrop'}),
    const import_1.Decorator(selector: '[ng-error]', map: const {'ng-error': '&onError'}),
    const import_1.Decorator(selector: '[ng-focus]', map: const {'ng-focus': '&onFocus'}),
    const import_1.Decorator(selector: '[ng-fullscreenchange]', map: const {'ng-fullscreenchange': '&onFullscreenChange'}),
    const import_1.Decorator(selector: '[ng-fullscreenerror]', map: const {'ng-fullscreenerror': '&onFullscreenError'}),
    const import_1.Decorator(selector: '[ng-input]', map: const {'ng-input': '&onInput'}),
    const import_1.Decorator(selector: '[ng-invalid]', map: const {'ng-invalid': '&onInvalid'}),
    const import_1.Decorator(selector: '[ng-keydown]', map: const {'ng-keydown': '&onKeyDown'}),
    const import_1.Decorator(selector: '[ng-keypress]', map: const {'ng-keypress': '&onKeyPress'}),
    const import_1.Decorator(selector: '[ng-keyup]', map: const {'ng-keyup': '&onKeyUp'}),
    const import_1.Decorator(selector: '[ng-load]', map: const {'ng-load': '&onLoad'}),
    const import_1.Decorator(selector: '[ng-mousedown]', map: const {'ng-mousedown': '&onMouseDown'}),
    const import_1.Decorator(selector: '[ng-mouseenter]', map: const {'ng-mouseenter': '&onMouseEnter'}),
    const import_1.Decorator(selector: '[ng-mouseleave]', map: const {'ng-mouseleave': '&onMouseLeave'}),
    const import_1.Decorator(selector: '[ng-mousemove]', map: const {'ng-mousemove': '&onMouseMove'}),
    const import_1.Decorator(selector: '[ng-mouseout]', map: const {'ng-mouseout': '&onMouseOut'}),
    const import_1.Decorator(selector: '[ng-mouseover]', map: const {'ng-mouseover': '&onMouseOver'}),
    const import_1.Decorator(selector: '[ng-mouseup]', map: const {'ng-mouseup': '&onMouseUp'}),
    const import_1.Decorator(selector: '[ng-mousewheel]', map: const {'ng-mousewheel': '&onMouseWheel'}),
    const import_1.Decorator(selector: '[ng-paste]', map: const {'ng-paste': '&onPaste'}),
    const import_1.Decorator(selector: '[ng-reset]', map: const {'ng-reset': '&onReset'}),
    const import_1.Decorator(selector: '[ng-scroll]', map: const {'ng-scroll': '&onScroll'}),
    const import_1.Decorator(selector: '[ng-search]', map: const {'ng-search': '&onSearch'}),
    const import_1.Decorator(selector: '[ng-select]', map: const {'ng-select': '&onSelect'}),
    const import_1.Decorator(selector: '[ng-selectstart]', map: const {'ng-selectstart': '&onSelectStart'}),
    const import_1.Decorator(selector: '[ng-submit]', map: const {'ng-submit': '&onSubmit'}),
    const import_1.Decorator(selector: '[ng-toucheancel]', map: const {'ng-touchcancel': '&onTouchCancel'}),
    const import_1.Decorator(selector: '[ng-touchend]', map: const {'ng-touchend': '&onTouchEnd'}),
    const import_1.Decorator(selector: '[ng-touchenter]', map: const {'ng-touchenter': '&onTouchEnter'}),
    const import_1.Decorator(selector: '[ng-touchleave]', map: const {'ng-touchleave': '&onTouchLeave'}),
    const import_1.Decorator(selector: '[ng-touchmove]', map: const {'ng-touchmove': '&onTouchMove'}),
    const import_1.Decorator(selector: '[ng-touchstart]', map: const {'ng-touchstart': '&onTouchStart'}),
    const import_1.Decorator(selector: '[ng-transitionend]', map: const {'ng-transitionend': '&onTransitionEnd'}),
  ],
  import_2.NgCloak: const [
    const import_1.Decorator(selector: '[ng-cloak]'),
    const import_1.Decorator(selector: '.ng-cloak'),
  ],
  import_2.NgIf: const [
    const import_1.Decorator(children: import_1.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-if]', map: const {'.': '=>condition'}),
  ],
  import_2.NgUnless: const [
    const import_1.Decorator(children: import_1.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-unless]', map: const {'.': '=>condition'}),
  ],
  import_2.NgInclude: const [
    const import_1.Decorator(selector: '[ng-include]', map: const {'ng-include': '@url'}),
  ],
  import_2.NgModel: const [
    const import_1.Decorator(selector: '[ng-model]', map: const {'name': '@name', 'ng-model': '&model'}),
  ],
  import_2.InputCheckbox: const [
    const import_1.Decorator(selector: 'input[type=checkbox][ng-model]'),
  ],
  import_2.InputTextLike: const [
    const import_1.Decorator(selector: 'textarea[ng-model]'),
    const import_1.Decorator(selector: 'input[type=text][ng-model]'),
    const import_1.Decorator(selector: 'input[type=password][ng-model]'),
    const import_1.Decorator(selector: 'input[type=url][ng-model]'),
    const import_1.Decorator(selector: 'input[type=email][ng-model]'),
    const import_1.Decorator(selector: 'input[type=search][ng-model]'),
    const import_1.Decorator(selector: 'input[type=tel][ng-model]'),
    const import_1.Decorator(selector: 'input[type=color][ng-model]'),
  ],
  import_2.InputNumberLike: const [
    const import_1.Decorator(selector: 'input[type=number][ng-model]'),
    const import_1.Decorator(selector: 'input[type=range][ng-model]'),
  ],
  import_2.NgBindTypeForDateLike: const [
    const import_1.Decorator(selector: 'input[type=date][ng-model][ng-bind-type]', visibility: import_1.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_1.Decorator(selector: 'input[type=time][ng-model][ng-bind-type]', visibility: import_1.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_1.Decorator(selector: 'input[type=datetime][ng-model][ng-bind-type]', visibility: import_1.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_1.Decorator(selector: 'input[type=datetime-local][ng-model][ng-bind-type]', visibility: import_1.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_1.Decorator(selector: 'input[type=month][ng-model][ng-bind-type]', visibility: import_1.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
    const import_1.Decorator(selector: 'input[type=week][ng-model][ng-bind-type]', visibility: import_1.Visibility.LOCAL, map: const {'ng-bind-type': '@idlAttrKind'}),
  ],
  import_2.InputDateLike: const [
    const import_1.Decorator(selector: 'input[type=date][ng-model]', module: import_2.InputDateLike.moduleFactory),
    const import_1.Decorator(selector: 'input[type=time][ng-model]', module: import_2.InputDateLike.moduleFactory),
    const import_1.Decorator(selector: 'input[type=datetime][ng-model]', module: import_2.InputDateLike.moduleFactory),
    const import_1.Decorator(selector: 'input[type=datetime-local][ng-model]', module: import_2.InputDateLike.moduleFactory),
    const import_1.Decorator(selector: 'input[type=month][ng-model]', module: import_2.InputDateLike.moduleFactory),
    const import_1.Decorator(selector: 'input[type=week][ng-model]', module: import_2.InputDateLike.moduleFactory),
  ],
  import_2.NgValue: const [
    const import_1.Decorator(selector: 'input[type=radio][ng-model][ng-value]', visibility: import_1.Visibility.LOCAL, map: const {'ng-value': '=>value'}),
    const import_1.Decorator(selector: 'option[ng-value]', visibility: import_1.Visibility.LOCAL, map: const {'ng-value': '=>value'}),
  ],
  import_2.NgTrueValue: const [
    const import_1.Decorator(selector: 'input[type=checkbox][ng-model][ng-true-value]', map: const {'ng-true-value': '=>value'}),
  ],
  import_2.NgFalseValue: const [
    const import_1.Decorator(selector: 'input[type=checkbox][ng-model][ng-false-value]', map: const {'ng-false-value': '=>value'}),
  ],
  import_2.InputRadio: const [
    const import_1.Decorator(selector: 'input[type=radio][ng-model]', module: import_2.NgValue.module),
  ],
  import_2.ContentEditable: const [
    const import_1.Decorator(selector: '[contenteditable][ng-model]'),
  ],
  import_2.NgPluralize: const [
    const import_1.Decorator(selector: 'ng-pluralize', map: const {'count': '=>count'}),
    const import_1.Decorator(selector: '[ng-pluralize]', map: const {'count': '=>count'}),
  ],
  import_2.NgRepeat: const [
    const import_1.Decorator(children: import_1.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-repeat]', map: const {'.': '@expression'}),
  ],
  import_2.NgTemplate: const [
    const import_1.Decorator(selector: 'template[type=text/ng-template]', map: const {'id': '@templateUrl'}),
    const import_1.Decorator(selector: 'script[type=text/ng-template]', children: import_1.Directive.IGNORE_CHILDREN, map: const {'id': '@templateUrl'}),
  ],
  import_2.NgHide: const [
    const import_1.Decorator(selector: '[ng-hide]', map: const {'ng-hide': '=>hide'}),
  ],
  import_2.NgShow: const [
    const import_1.Decorator(selector: '[ng-show]', map: const {'ng-show': '=>show'}),
  ],
  import_2.NgBooleanAttribute: const [
    const import_1.Decorator(selector: '[ng-checked]', map: const {'ng-checked': '=>checked'}),
    const import_1.Decorator(selector: '[ng-disabled]', map: const {'ng-disabled': '=>disabled'}),
    const import_1.Decorator(selector: '[ng-multiple]', map: const {'ng-multiple': '=>multiple'}),
    const import_1.Decorator(selector: '[ng-open]', map: const {'ng-open': '=>open'}),
    const import_1.Decorator(selector: '[ng-readonly]', map: const {'ng-readonly': '=>readonly'}),
    const import_1.Decorator(selector: '[ng-required]', map: const {'ng-required': '=>required'}),
    const import_1.Decorator(selector: '[ng-selected]', map: const {'ng-selected': '=>selected'}),
  ],
  import_2.NgSource: const [
    const import_1.Decorator(selector: '[ng-href]', map: const {'ng-href': '@href'}),
    const import_1.Decorator(selector: '[ng-src]', map: const {'ng-src': '@src'}),
    const import_1.Decorator(selector: '[ng-srcset]', map: const {'ng-srcset': '@srcset'}),
  ],
  import_2.NgAttribute: const [
    const import_1.Decorator(selector: '[ng-attr-*]'),
  ],
  import_2.NgStyle: const [
    const import_1.Decorator(selector: '[ng-style]', map: const {'ng-style': '@styleExpression'}, exportExpressionAttrs: const ['ng-style',]),
  ],
  import_2.NgSwitch: const [
    const import_1.Decorator(selector: '[ng-switch]', map: const {'ng-switch': '=>value', 'change': '&onChange'}, visibility: import_1.Directive.DIRECT_CHILDREN_VISIBILITY),
  ],
  import_2.NgSwitchWhen: const [
    const import_1.Decorator(selector: '[ng-switch-when]', children: import_1.Directive.TRANSCLUDE_CHILDREN, map: const {'.': '@value'}),
  ],
  import_2.NgSwitchDefault: const [
    const import_1.Decorator(children: import_1.Directive.TRANSCLUDE_CHILDREN, selector: '[ng-switch-default]'),
  ],
  import_2.NgNonBindable: const [
    const import_1.Decorator(selector: '[ng-non-bindable]', children: import_1.Directive.IGNORE_CHILDREN),
  ],
  import_2.InputSelect: const [
    const import_1.Decorator(selector: 'select[ng-model]', visibility: import_1.Visibility.CHILDREN),
  ],
  import_2.OptionValue: const [
    const import_1.Decorator(selector: 'option', module: import_2.NgValue.module),
  ],
  import_2.NgForm: const [
    const import_1.Decorator(selector: 'form', module: import_2.NgForm.module, map: const {'name': '@name'}),
    const import_1.Decorator(selector: 'fieldset', module: import_2.NgForm.module, map: const {'name': '@name'}),
    const import_1.Decorator(selector: '.ng-form', module: import_2.NgForm.module, map: const {'name': '@name'}),
    const import_1.Decorator(selector: '[ng-form]', module: import_2.NgForm.module, map: const {'ng-form': '@name', 'name': '@name'}),
  ],
  import_2.NgModelRequiredValidator: const [
    const import_1.Decorator(selector: '[ng-model][required]'),
    const import_1.Decorator(selector: '[ng-model][ng-required]', map: const {'ng-required': '=>required'}),
  ],
  import_2.NgModelUrlValidator: const [
    const import_1.Decorator(selector: 'input[type=url][ng-model]'),
  ],
  import_2.NgModelColorValidator: const [
    const import_1.Decorator(selector: 'input[type=color][ng-model]'),
  ],
  import_2.NgModelEmailValidator: const [
    const import_1.Decorator(selector: 'input[type=email][ng-model]'),
  ],
  import_2.NgModelNumberValidator: const [
    const import_1.Decorator(selector: 'input[type=number][ng-model]'),
    const import_1.Decorator(selector: 'input[type=range][ng-model]'),
  ],
  import_2.NgModelMaxNumberValidator: const [
    const import_1.Decorator(selector: 'input[type=number][ng-model][max]', map: const {'max': '@max'}),
    const import_1.Decorator(selector: 'input[type=range][ng-model][max]', map: const {'max': '@max'}),
    const import_1.Decorator(selector: 'input[type=number][ng-model][ng-max]', map: const {'ng-max': '=>max', 'max': '@max'}),
    const import_1.Decorator(selector: 'input[type=range][ng-model][ng-max]', map: const {'ng-max': '=>max', 'max': '@max'}),
  ],
  import_2.NgModelMinNumberValidator: const [
    const import_1.Decorator(selector: 'input[type=number][ng-model][min]', map: const {'min': '@min'}),
    const import_1.Decorator(selector: 'input[type=range][ng-model][min]', map: const {'min': '@min'}),
    const import_1.Decorator(selector: 'input[type=number][ng-model][ng-min]', map: const {'ng-min': '=>min', 'min': '@min'}),
    const import_1.Decorator(selector: 'input[type=range][ng-model][ng-min]', map: const {'ng-min': '=>min', 'min': '@min'}),
  ],
  import_2.NgModelPatternValidator: const [
    const import_1.Decorator(selector: '[ng-model][pattern]', map: const {'pattern': '@pattern'}),
    const import_1.Decorator(selector: '[ng-model][ng-pattern]', map: const {'ng-pattern': '=>pattern', 'pattern': '@pattern'}),
  ],
  import_2.NgModelMinLengthValidator: const [
    const import_1.Decorator(selector: '[ng-model][minlength]', map: const {'minlength': '@minlength'}),
    const import_1.Decorator(selector: '[ng-model][ng-minlength]', map: const {'ng-minlength': '=>minlength', 'minlength': '@minlength'}),
  ],
  import_2.NgModelMaxLengthValidator: const [
    const import_1.Decorator(selector: '[ng-model][maxlength]', map: const {'maxlength': '@maxlength'}),
    const import_1.Decorator(selector: '[ng-model][ng-maxlength]', map: const {'ng-maxlength': '=>maxlength', 'maxlength': '@maxlength'}),
  ],
  import_2.NgModelOptions: const [
    const import_1.Decorator(selector: 'input[ng-model-options]', map: const {'ng-model-options': '=>options'}),
  ],
  import_3.TextMustache: const [
    const import_1.Decorator(selector: r':contains(/{{.*}}/)'),
  ],
  import_3.AttrMustache: const [
    const import_1.Decorator(selector: r'[*=/{{.*}}/]'),
  ],
  import_3.Content: const [
    const import_1.Decorator(selector: 'content'),
  ],
  import_4.JobListingController: const [
    const import_1.Controller(selector: '[job-listing]', publishAs: 'ctrl'),
  ],
  import_5.NgAnimate: const [
    const import_1.Decorator(selector: '[ng-animate]', map: const {'ng-animate': '@option'}),
  ],
  import_5.NgAnimateChildren: const [
    const import_1.Decorator(selector: '[ng-animate-children]', map: const {'ng-animate-children': '@option'}),
  ],
  import_6.NgView: const [
    const import_1.Decorator(selector: 'ng-view', module: import_6.NgView.module, visibility: import_1.Visibility.CHILDREN),
  ],
  import_6.NgBindRoute: const [
    const import_1.Decorator(selector: '[ng-bind-route]', module: import_6.NgBindRoute.module, map: const {'ng-bind-route': '@routeName'}),
  ],
  import_7.SearchJobComponent: const [
    const import_1.Component(selector: 'search-job', templateUrl: 'packages/angular_view/component/search_job_component.html', publishAs: 'cmp', map: const {'type-filter': '<=>typeFilter', 'company-filter-map': '<=>companyFilterMap'}),
  ],
  import_8.SalaryComponent: const [
    const import_1.Component(selector: 'salary', templateUrl: 'packages/angular_view/salary/salary_component.html', cssUrl: 'packages/angular_view/salary/salary_component.css', publishAs: 'cmp', map: const {'salary': '=>salary', 'max-sal': '@maxSal'}),
  ],
  import_9.CompanyFilter: const [
    const import_1.Formatter(name: 'companyfilter'),
  ],
};
