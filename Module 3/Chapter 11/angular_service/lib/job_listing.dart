library job_listing_controller;

import 'package:angular/angular.dart';
import 'model/job.dart';

@Controller(selector: '[job-listing]', publishAs: 'ctrl')
class JobListingController {
  Job selectedJob;
  List<Job> jobs;
  List companies = [];
  final Http _http;

  static const String LOADING_MESSAGE = "Loading jobs listing...";
  static const String ERROR_MESSAGE = "Sorry! The jobs database cannot be reached.";
  String message = LOADING_MESSAGE;
  bool jobsLoaded = false;
  // Filter box
  final companyFilterMap = <String, bool>{};
  String typeFilterString = "";

  JobListingController(this._http) {
    _loadData();
  }

  void selectJob(Job job) {
    selectedJob = job;
  }

  void clearFilters() {
    companyFilterMap.clear();
    typeFilterString = "";
  }

  void _loadData() {
    jobsLoaded = false;
    _http.get('jobs.json')
      .then((HttpResponse response) {
        jobs = response.data.map((d) => new Job.fromJson(d)).toList();
        jobsLoaded = true;
        for (var job in jobs) { // extract companies:
          companies.add(job.company);
        }
    })
      .catchError((e) {
        print(e);
        message = ERROR_MESSAGE;
      });
   }
}