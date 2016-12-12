import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:angular_service/salary/salary_component.dart';
import 'package:angular_service/job_listing.dart';
import 'package:angular_service/formatter/company_filter.dart';

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
  }
}