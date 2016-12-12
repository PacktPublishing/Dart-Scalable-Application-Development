import 'dart:async';
import 'dart:isolate';

main() {
  var recv = new ReceivePort();
  Future<Isolate> remote =
      Isolate.spawnUri(Uri.parse("echo.dart"),
                      ["Do you hear me?"], recv.sendPort);
  remote.then((_) => recv.first).then((msg) {
    print("MAIN: received $msg");
  });
}
// MAIN: received Do you hear me?