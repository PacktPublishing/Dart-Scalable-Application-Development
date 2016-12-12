import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:angular_formatter/salary/salary_component.dart';
import 'package:angular_formatter/job_listing.dart';
import 'package:angular_formatter/formatter/company_filter.dart';
import 'package:angular_formatter/formatter/uppercase_formatter.dart';

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
    bind(UppercaseFormatter);
  }
}