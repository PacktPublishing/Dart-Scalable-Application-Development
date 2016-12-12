import 'package:worker/worker.dart';
import 'dart:async';

Worker worker;
List<Future> tasks;

void main() {
  // 1- Make a Task object:
  Task task = new HeavyTask();
  // adding a number of Tasks:
//  int noTasks = 500;
//  for (var i=1; i<=noTasks; i++) {
//      tasks.add(worker.handle(new HeavyTask()));
//  }
  // 2- Construct a Worker object:
  worker = new Worker();
  // alternative specifying poolSize and spawning lazy isolates or not:
  // worker = new Worker(poolSize: noIsol, spawnLazily: false);
  // 3- Give a task to the worker
  // when the results return, process them
  worker.handle(task).then(processResult);
  // processing a number of tasks:
  // Future.wait(tasks).then(processResult);
}

// 5- Task custom class must implement Task interface
class HeavyTask implements Task {

  execute() {
    return longRunningComputation();
  }

  bool longRunningComputation() {
    var stopWatch = new Stopwatch();
    stopWatch.start();
    while (stopWatch.elapsedMilliseconds < 1000);
    stopWatch.stop();
    return true;
  }
}

processResult(result) {
  print(result);
  // process result
// 4- Close the worker object(s)
  worker.close();
}

// true