import 'dart:async';
import 'dart:isolate';

main() {
  // 1- make a ReceivePort for the main isolate:
  var recv = new ReceivePort();
  // 2- spawn a new isolate that runs the code from the echo function
  // and pass it a sendPort to send messages to the main isolate
   Future<Isolate> remote = Isolate.spawn(echo, recv.sendPort);
  // 3- when the isolate is spawned (then), take the first message
  remote.then((_) => recv.first).then((sendPort) {
  // 4- send a message to the isolate:
    sendReceive(sendPort, "Do you hear me?").then((msg) {
  // 5- listen and print the answer from the isolate
      print("MAIN: received $msg");
  // 6- send signal to end isolate:
      return sendReceive(sendPort, "END");
    }).catchError((e) => print('Error in spawning isolate $e'));
  });
}

// the spawned isolate:
void echo(sender) {
  // 7- make a ReceivePort for the 2nd isolate:
  var port = new ReceivePort();
  // 8- send its sendPort to main isolate:
  sender.send(port.sendPort);
  // 9- listen to messages
  port.listen((msg) {
    var data = msg[0];
    print("ISOL: received $msg");
    SendPort replyTo = msg[1];
    replyTo.send('Yes I hear you: $msg, echoed from spawned isolate');
   // 10- received END signal, close the ReceivePort to save resources:
   if (data == "END") {
      print('ISOL: my receivePort will be closed');
      port.close();
    }
  });
}

Future sendReceive(SendPort port, msg) {
  ReceivePort recv = new ReceivePort();
  port.send([msg, recv.sendPort]);
  return recv.first;
}