import 'dart:html';
import 'dart:convert';

main() {
  LoadData();
}
void LoadData() {
  var url = 'http://query.yahooapis.com/v1/public/yql?q=';
  var select = 'select * from yahoo.finance.quotes where symbol in ("GOOG")';
  var format = '&env=http://datatables.org/Falltables.env&format=json';
  var request =  url + Uri.encodeComponent(select + format);

//  var stock = "GOOG";
//  var request = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20"
//                "where%20symbol%20in%20(%22$stock%22)%0A%09%09"
//                "&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json";
  // call the web server asynchronously
  var result = HttpRequest.getString(request).then(OnDataLoaded);
}

// Web service response callback
void OnDataLoaded(String response) {
  String json = response.substring(response.indexOf("symbol") - 2, response.length - 3);
  Map data = JSON.decode(json);
  var table = CreateTable();
  var props = data.keys;
  props.forEach((prop) => ProcessStockEntry(prop, data, table));
  document.body.nodes.add(table);
}

TableElement CreateTable() {
TableElement table = new TableElement();
var tBody = table.createTBody();
return table;
}

void ProcessStockEntry(String prop, Map data, TableElement table) {
  String value = data["$prop"];
  // Add new row to our table
  var row = table.insertRow(-1);
  // Add new cell for the property
  var propCell = row.insertCell(0);
  String prophtml = '$prop:';
  propCell.setInnerHtml(prophtml);
  // Add new cell for the value
  var valueCell = row.insertCell(1);
  String valuehtml = '$value';
  valueCell.setInnerHtml(valuehtml);
}