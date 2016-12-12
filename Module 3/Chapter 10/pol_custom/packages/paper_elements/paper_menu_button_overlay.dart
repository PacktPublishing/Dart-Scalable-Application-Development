// DO NOT EDIT: auto-generated with core_elements/tool/generate_dart_api.dart

/// Dart API for the polymer element `paper_menu_button_overlay`.
library core_elements.paper_menu_button_overlay;

import 'dart:html';
import 'dart:js' show JsArray;
import 'package:web_components/interop.dart' show registerDartType;
import 'package:polymer/polymer.dart' show initMethod;
import 'package:core_elements/core_overlay.dart';

/// `paper-menu-button-overlay` is a helper class to position an overlay relative to another
/// element, e.g. the button with a pulldown menu.
class PaperMenuButtonOverlay extends CoreOverlay {
  PaperMenuButtonOverlay.created() : super.created();

  /// The `relatedTarget` is an element used to position the overlay, for example a
  /// button the user taps to show a menu.
  get relatedTarget => jsElement['relatedTarget'];
  set relatedTarget(value) { jsElement['relatedTarget'] = value; }

  /// The horizontal alignment of the overlay relative to the `relatedTarget`.
  get halign => jsElement['halign'];
  set halign(value) { jsElement['halign'] = value; }
}
@initMethod
upgradePaperMenuButtonOverlay() => registerDartType('paper-menu-button-overlay', PaperMenuButtonOverlay);
