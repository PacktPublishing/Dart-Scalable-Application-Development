import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:angular_view/salary/salary_component.dart';
import 'package:angular_view/job_listing.dart';
import 'package:angular_view/formatter/company_filter.dart';
import 'package:angular_view/component/search_job_component.dart';


void main() {
  applicationFactory()
        .addModule(new AppModule())
        .run();
}

class AppModule extends Module {
  AppModule() {
    bind(JobListingController);
    bind(SalaryComponent);
    bind(CompanyFilter);
    bind(SearchJobComponent);
  }
}