import 'dart:isolate';
import 'dart:html';
import 'dart:async';

main() {
  Element output = querySelector('output');
  SendPort sendPort;
  ReceivePort receivePort = new ReceivePort();
  receivePort.listen((msg) {
    if (sendPort == null) {
      sendPort = msg;
    } else {
      output.text += 'Received from isolate: $msg\n';
    }
  });

  // dart2js adds .js to the end.
  String workerUri = 'worker.dart';
  for (int i = 1; i <= 3; i++) {
    int counter = 0;
    Isolate.spawnUri(Uri.parse(workerUri), [], receivePort.sendPort).then((isolate) {
      print('isolate spawned');
      new Timer.periodic(const Duration(seconds: 1), (t) {
        sendPort.send('From main app: ${counter++}');
        if (counter == 10) {
          sendPort.send('END');
          t.cancel();
        }
      });
    });
  }
}
