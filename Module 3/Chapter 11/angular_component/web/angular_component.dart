import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular_component/salary/salary_component.dart';
import 'package:angular_component/job_listing.dart';

void main() {
  applicationFactory()
        .addModule(new AppModule())
        .run();
}

class AppModule extends Module {
  AppModule() {
    bind(JobListingController);
    bind(SalaryComponent);
  }
}