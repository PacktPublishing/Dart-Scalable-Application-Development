import 'package:worker/worker.dart';

void main () {
    Worker worker = new Worker();
    Task task = new AckermannTask(1, 2);
    worker.handle(task).then((result) {
      print(result);
      worker.close();
    });
}

class AckermannTask implements Task {
  int x, y;

  AckermannTask (this.x, this.y);

  int execute () {
    return ackermann(x, y);
  }

  int ackermann (int m, int n) {
    if (m == 0)
      return n+1;
    else if (m > 0 && n == 0)
      return ackermann(m-1, 1);
    else
      return ackermann(m-1, ackermann(m, n-1));
  }
}
// Output: 4
