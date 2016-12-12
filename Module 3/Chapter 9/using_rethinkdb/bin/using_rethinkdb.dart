import 'job.dart';
import 'jobstore_rethinkdb.dart';

Job job;
JobStore js;

void main() {
  js = new JobStore();
// 1- create some jobs:
  job = new Job("Web Developer", 7500, "Google", new DateTime.now());
  js.jobs.add(job);
  job = new Job("Software Engineer", 5500, "Microsoft", new DateTime.now());
  js.jobs.add(job);
  job = new Job("Tester", 4500, "Mozilla", new DateTime.now());
  js.jobs.add(job);
// 2- storing data in database:
   js.openAndStore();
// 3- retrieving and displaying data from database:
  js.openAndRead();
}