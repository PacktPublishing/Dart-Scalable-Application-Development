library company_filter;

import 'package:angular/angular.dart';

@Formatter(name: 'companyfilter')
class CompanyFilter {
  List call(JobList, filterMap) {
    if (JobList is Iterable && filterMap is Map) {
      // If there is nothing checked, treat it as "everything is checked"
      bool nothingChecked = filterMap.values.every((isChecked) => !isChecked);
      return nothingChecked
          ? JobList.toList()
          : JobList.where((i) => filterMap[i.company] == true).toList();
    }
    return const [];
  }
}