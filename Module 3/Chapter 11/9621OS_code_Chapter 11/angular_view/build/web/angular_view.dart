import 'package:angular/angular.dart';
import 'package:angular/application_factory_static.dart';

import 'package:angular_view/salary/salary_component.dart';
import 'package:angular_view/job_listing.dart';
import 'package:angular_view/formatter/company_filter.dart';
import 'package:angular_view/component/search_job_component.dart';
import 'angular_view_generated_type_factory_maps.dart' show setStaticReflectorAsDefault;
import 'angular_view_static_expressions.dart' as generated_static_expressions;
import 'angular_view_static_metadata.dart' as generated_static_metadata;


void main() {
  setStaticReflectorAsDefault();
  staticApplicationFactory(generated_static_metadata.typeAnnotations, generated_static_expressions.getters, generated_static_expressions.setters, generated_static_expressions.symbols)
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