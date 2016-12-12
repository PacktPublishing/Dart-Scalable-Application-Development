import "package:worker/worker.dart";
import "dart:async";

void main() {
  final worker = new Worker();
  var futures = [];

  for (var i in [10, 20, 30, 40, 31, 21]) {
    futures.add(worker.handle(new FibTask(i)));
  }

  Future.wait(futures).then((res) {
    print(res);
    worker.close();
  });
}

class FibTask extends Task {
  int n;
  FibTask(this.n);
  execute() => fib(n);
}

int fib(int n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fib(n-1) + fib(n-2);
}
// Output: [55, 6765, 832040, 102334155, 1346269, 10946]
