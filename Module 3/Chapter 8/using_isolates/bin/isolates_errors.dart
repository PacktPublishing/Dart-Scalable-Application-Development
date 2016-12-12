import "dart:isolate";

void main() {
  var port = new ReceivePort();
  print("Main.");
  Isolate.spawn(runInIsolate, port.sendPort)
         .then(processResultFromIsolate)
         .catchError((IsolateSpawnException e) => print('Error in spawning isolate $e'));
}

runInIsolate(SendPort sp) {
  print("In Isolate");
  throw "Sorry: exception occurred!";
}

processResultFromIsolate(Isolate isl) {
  print("In processing");
}