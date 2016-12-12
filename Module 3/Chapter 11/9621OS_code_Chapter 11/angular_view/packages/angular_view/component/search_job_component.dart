library search_job_component;

import 'package:angular/angular.dart';

@Component(
    selector: 'search-job',
    templateUrl: 'packages/angular_view/component/search_job_component.html',
    publishAs: 'cmp')
class SearchJobComponent {
  Map<String, bool> _companyFilterMap;
  List<String> _companies;

  @NgTwoWay('type-filter')
  String typeFilter = "";

  @NgTwoWay('company-filter-map')
  Map<String, bool> get companyFilterMap => _companyFilterMap;
  void set companyFilterMap(values) {
    _companyFilterMap = values;
    _companies = companyFilterMap.keys.toList();
  }

  List<String> get companies => _companies;

  void clearFilters() {
    _companyFilterMap.keys.forEach((f) => _companyFilterMap[f] = false);
    typeFilter = "";
  }
}