import 'dart:isolate';

void main(List<String> args, SendPort replyTo) {
  replyTo.send(args[0]);
}
