part of bank_terminal;

final Logger log = new Logger('Bank Account');

/**
 * Class for normal bank accounts.
 */
class BankAccount {
  String _number;
  Person owner;
  /// Amount of money contained in this account.
  double _balance;
  int _pin_code;
  final DateTime date_created;
  DateTime date_modified;
  static const double INTEREST = 5.0;

  String get number => _number;
  set number(value) {
    if (value == null || value.isEmpty) return;
    // test the format:
    RegExp exp = new RegExp(r"[0-9]{3}-[0-9]{7}-[0-9]{2}");
    if (exp.hasMatch(value)) _number = value;
  }

  double get balance => _balance;
  set balance(value) {
    if (value >= 0) _balance = value;
  }

  int get pin_code => _pin_code;
  set pin_code(value) {
    if (value >= 1 && value <= 999999) _pin_code = value;
  }

  // constructors:
  BankAccount(this.owner, number, balance):  date_created = new DateTime.now() {
    this.number = number;
    this.balance = balance;
    date_modified = date_created;
    log.info('Bank Account is created');
  }
  BankAccount.sameOwner(BankAccount acc): owner = acc.owner, date_created = new DateTime.now();
  BankAccount.sameOwnerInit(BankAccount acc): this(acc.owner, "000-0000000-00", 0.0);

  BankAccount.fromJson(Map json):  date_created = DateTime.parse(json["creation_date"]) {
    this.number = json["number"];
    this.owner = new Person.fromJson(json["owner"]);
    this.balance = json["balance"];
    this.pin_code = json["pin_code"];
    this.date_modified = DateTime.parse(json["modified_date"]);
   }
  // methods:
  /**
   * Calculates the new balance for this account,
   * when a transaction (deposit or withdrawal) for amount is initiated.
   */
  transact(double amount) {
    balance += amount;
    if (amount < 0 && (-amount) > balance) {
      log.severe("Balance will go negative!");
    }
    date_modified = new DateTime.now();
  }

   interest() {
    balance += balance * INTEREST/100.0;
  }

  get hasAddress => !(owner.address).isEmpty;

  String toString() => 'Bank account from $owner with number $number'
      ' and balance $balance';

  String toJson() {
    var acc = new Map<String, Object>();
    acc["number"] = number;
    acc["owner"] = owner.toJson();
    acc["balance"] = balance;
    acc["pin_code"] = pin_code;
    acc["creation_date"] = date_created.toString();
    acc["modified_date"] = date_modified.toString();
    var accs = JSON.encode(acc); // use only once for the root object (here a bank account)
    return accs;
  }
}

