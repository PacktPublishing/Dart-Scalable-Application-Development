import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

void main() {
  applicationFactory()
        .addModule(new AppModule())
        .run();
}

class AppModule extends Module {
  AppModule() {
    bind(JobListingController);
  }
}

// model:
class Job {
  String type;
  int salary;
  String company;
  DateTime posted; // date of publication of job
  bool open = true; // is job still vacant?
  List<String> skills;
  String info;
  Job(this.type, this.salary, this.company, this.posted, this.skills, this.info);
}

@Component(
    selector: '[job-listing]',
    publishAs: 'ctrl',
    templateUrl: 'angular_controller.html',
    cssUrl: 'angular_controller.css')
class JobListingController {
  Job selectedJob;
  List<Job> jobs;

  JobListingController() {
    jobs = _loadData();
  }

  void selectJob(Job job) {
    selectedJob = job;
  }

  // model data:
  List<Job> _loadData() {
    return [
      new Job('Web Developer',8000, 'Google', DateTime.parse('2014-07-03'),
          ["HTML5", "CSS", "Dart"], "on-site job Palo Alto, California"),
      new Job('Software Engineer',6000, 'Microsoft', DateTime.parse('2014-09-03'),
          ["C#", "ASP.NET", "UML"], "good teamspirit"),
      new Job('Tester',5000, 'Mozilla', DateTime.parse('2014-12-03'),
          ["Rust", "Firefox", "C++"], "work on the browser of the future"),
      new Job('Julia Developer',7000, 'Julia computing', DateTime.parse('2014-15-03'),
          ["Julia", "Matlab", "R"], "model the world with Julia"),
     ];
  }
}