import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:bank_terminal/bank_terminal.dart';

@CustomTag('bank-app')
class BankApp extends PolymerElement {
  @observable BankAccount bac;
  @observable double balance;
  double amount = 0.0;

  BankApp.created() : super.created() { }

  @override
  attached() {
    super.attached();
    var jw = new Person("John Witgenstein");
    bac = new BankAccount(jw, "456-0692322-12", 1500.0);
    balance = bac.balance;
  }

  transact(Event e, var detail, Node target) {
      InputElement amountInput = shadowRoot.querySelector("#amount");
      if (!checkAmount(amountInput.value)) return;
      bac.transact(amount);
      balance = bac.balance;
    }

    enter(KeyboardEvent e, var detail, Node target) {
      if (e.keyCode == KeyCode.ENTER) {
        transact(e, detail, target);
      }
    }

    checkAmount(String in_amount) {
      try {
        amount = double.parse(in_amount);
      } on FormatException catch(ex) {
        return false;
      }
      return true;
    }
}