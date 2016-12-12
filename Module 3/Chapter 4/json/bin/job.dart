import 'dart:convert';

void main() {
 var job = new Job("Software Developer", 7500, "Julia Computing LLC") ;
 var jsonStr = job.toJson();
 print(jsonStr);
 var job2 = new Job.fromJson(jsonStr);
 assert(job2 is Job);
 assert(job2.toJson() == jsonStr);
}

class Job {
  String type;
  int salary;
  String company;
  Job(this.type, this.salary, this.company);

  // String get toJson => '{ "type": "$type", "salary": "$salary", "company": "$company" } ';

  // encoding or serializing data:
  String toJson() {
    var jsm = new Map<String, Object>();
    jsm["type"] = type;
    jsm["salary"] = salary;
    jsm["company"] = company;
    var jss = JSON.encode(jsm);
    return jss;
  }

  // decoding or deserializing data:
  Job.fromJson(String jsonStr) {
    Map jsm = JSON.decode(jsonStr);
    this.type = jsm["type"];
    this.salary = jsm["salary"];
    this.company = jsm["company"];
  }
}
// toJson:
// {"type":"Software Developer","salary":7500,"company":"Julia Computing LLC"}