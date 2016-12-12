import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

@CustomTag('localized-text')
class LocalizedText extends PolymerElement {
  @observable String selectedLocale;
  @observable String startMsg;

  LocalizedText.created() : super.created() {
    updateLocale(Intl.defaultLocale);
  }

  void selectedLocaleChanged() {
    initializeMessages(selectedLocale).then(
        (succeeded) => updateLocale(selectedLocale));
  }

  void updateLocale(localeName) {
    Intl.defaultLocale = selectedLocale;
    startMsg = start();
  }

  start() => Intl.message("Please choose your language and then start the tour.",
      name: 'startMsg',
      desc: "Starting the tour",
      args: [], // needed if arguments.
      examples: {"We could put examples of parameter values here for the "
        "translators if we had any parameters" : 0});
}
