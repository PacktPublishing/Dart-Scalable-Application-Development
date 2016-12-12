library job_listing_controller;

import 'package:angular/angular.dart';
import 'model/job.dart';

@Controller(selector: '[job-listing]', publishAs: 'ctrl')
class JobListingController {
  Job selectedJob;
  List<Job> jobs;
  List companies = [];

  JobListingController() {
    jobs = _loadData();
    // extract companies:
    var job;
    for (job in jobs) {
      companies.add(job.company);
    }
  }

  // Filter box
  final companyFilterMap = <String, bool>{};
  String typeFilterString = "";

  void selectJob(Job job) {
    selectedJob = job;
  }

  void clearFilters() {
    companyFilterMap.clear();
    typeFilterString = "";
  }

  // model data:
  List<Job> _loadData() {
    jobs = [new Job('Web Developer', 8000, 'Google', DateTime.parse('2014-07-03'),
              ["HTML5", "CSS", "Dart"], "on-site job Palo Alto, California"),
            new Job('Software Engineer', 6000, 'Microsoft', DateTime.parse('2014-09-03'),
              ["C#", "ASP.NET", "UML"], "good teamspirit"),
            new Job('Tester', 4000, 'Mozilla', DateTime.parse('2014-12-03'),
              ["Rust", "Firefox", "C++"], "work on the browser of the future"),
            new Job('Julia Developer', 7000, 'Julia computing', DateTime.parse('2014-15-03'),
              ["Julia", "Matlab", "R"], "model the world with Julia"),];
    return jobs;
  }
}
