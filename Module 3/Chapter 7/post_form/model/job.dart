import 'dart:convert';

class Job {
  String type;
  int salary;
  String company;
  DateTime posted; // date of publication of job
  bool open = true; // is job still vacant ?
  Job(this.type, this.salary, this.company, this.posted);

  // String get toJson => '{ "type": "$type", "salary": "$salary", "company": "$company" } ';

  // encoding or serializing data:
  String toJson() {
    var jsm = new Map<String, Object>();
    jsm["type"] = type;
    jsm["salary"] = salary;
    jsm["company"] = company;
    jsm["posted"] = JSON.encode(posted, toEncodable: (p){
      if(p is DateTime)
        return p.toIso8601String();
      return p;
    });
    jsm["open"] = open;
    var jss = JSON.encode(jsm);
    return jss;
  }

  // decoding or deserializing data:
  Job.fromJson(String jsonStr) {
    Map jsm = JSON.decode(jsonStr);
    this.type = jsm["type"];
    this.salary = jsm["salary"];
    this.company = jsm["company"];
    this.posted = DateTime.parse(jsm["posted"]);
    this.open = jsm["open"];
  }
}