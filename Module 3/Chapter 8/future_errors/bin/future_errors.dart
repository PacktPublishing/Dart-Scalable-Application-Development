import 'dart:async';

void main() {
  // Examples working with futures:
  // 1) chaining futures:
  firstStep()
    .then((_) => secondStep())
    .then((_) => thirdStep())
    .then((_) => fourthStep())
    .catchError(handleError);
  // 2) concurrent Futures:
  List futs = [firstStep(), secondStep(), thirdStep(), fourthStep()];
  Future.wait(futs)
    .then((_) => processValues(_))
    .catchError(handleError);
  // 3) catching specific errors:
  firstStep()
      .then((_) => secondStep())
      .catchError(handleArgumentError,
                  test: (e) => e is ArgumentError)
      .catchError(handleFormatException,
                  test: (e) => e is FormatException)
      .catchError(handleRangeError,
                  test: (e) => e is RangeError)
      .catchError(handleException, test: (e) => e is Exception);
  // 4) whenComplete:
  firstStep()
      .then((_) => secondStep())
      .catchError(handleError)
      .whenComplete(cleanUp);
  // 5) Handling synchronous and asynchronous errors:
  var data;
  mixedFunction(data).catchError(handleError);
}

Future<String> firstStep() { return new Future.value("from firstStep");}
Future<String> secondStep() { return new Future.value("from secondStep");}
Future<String> thirdStep() { return new Future.value("from thirdStep");}
Future<String> fourthStep() { return new Future.value("from fourthStep");}
Future<String> finalStep() { return new Future.value("from finalStep");}
handleError(e) { print("Got error: ${e.toString()}");  }
processValues(e) { print("Processing values");  }
handleArgumentError(e) { print("Got argument error: ${e.error}");  }
handleFormatException(e) { print("Got formatexception: ${e.error}");  }
handleRangeError(e) { print("Got range error: ${e.error}");  }
handleException(e) { print("Got exception: ${e.error}");  }
cleanUp() {}
processResult(e) { print("Processing result");  }

class T {  }

// wrong version:
//mixedFunction(data) {
//  var var2 = new Var2();
//  var var1 = synFunc(data);         // Could throw error.
//  return var2.asynFunc().then(processResult);  // Could throw error.
//}

// correct version:
mixedFunction(data) {
  return new Future.sync(() {
    var var2 = new Var2();
    var var1 = synFunc(data);         // Could throw error.
    return var2.asynFunc().then(processResult);  // Could throw error.
  });
}

class Var2 {
  Future<String> asynFunc() { return new Future.value("from asynFunc");}
}

//
synFunc(data) {}

