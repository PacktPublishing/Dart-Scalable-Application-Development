import 'dart:isolate';

main() {
  int counter = 0;
  ReceivePort receivePort = new ReceivePort();
  receivePort.listen((msg) {
    if (msg is SendPort) {
      msg.send(counter++);
    } else {
      print(msg);
    }
  });
// starting isolates:
  for (var i = 0; i < 5; i++) {
    Isolate.spawn(runInIsolate, receivePort.sendPort);
  }
}
// code to run isolates
runInIsolate(SendPort sendPort) {
  ReceivePort receivePort = new ReceivePort();
// send own sendPort to main isolate
  sendPort.send(receivePort.sendPort);

  receivePort.listen((msg) {
    var k = 0;
    var max = (5 - msg) * 500000000;
    for (var i = 0; i < max; ++i) {
        i = ++i - 1;
        k = i;
    }
    sendPort.send("I received: $msg and calculated $k");
  });
}