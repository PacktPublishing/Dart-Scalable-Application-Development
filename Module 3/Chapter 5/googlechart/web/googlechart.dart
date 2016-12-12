/*
Based on the following example:
*  https://google-developers.appspot.com/chart/interactive/docs/gallery/columnchart
 * */

import 'dart:html';
import 'package:js/js.dart' as js;

var listData = [
                ['Year', 'Sales', 'Expenses'],
                ['2004',  1000,      400],
                ['2005',  1170,      460],
                ['2006',  660,       1120],
                ['2007',  1030,      540]
              ];

main() {
  js.context.google.load('visualization', '1', js.map(
    { 'packages': ['corechart'],
      'callback': drawChart,
    }));
}

void drawChart() {
  var gviz = js.context.google.visualization;
  var arrayData = js.array(listData);
  var tableData = gviz.arrayToDataTable(arrayData);
  var options = js.map({
    'title': 'Company Performance, ',
    'hAxis': {'title': 'Year', 'titleTextStyle': {'color': 'red'}}
  });
  var chart = new js.Proxy(gviz.ColumnChart, querySelector('#chart'));
  chart.draw(tableData, options);
}