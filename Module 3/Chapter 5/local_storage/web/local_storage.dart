import 'dart:html';

Storage local = window.localStorage;

void main() {
  var job1 = new Job(1, "Web Developer", 6500, "Dart Unlimited") ;
  // store in local storage:
  local["Job:${job1.id}"] = job1.toJson;
  ButtonElement bel = querySelector('#readls');
  bel.onClick.listen(readShowData);
}

 readShowData(Event e) {
   var key = 'Job:1';
   if(local.containsKey(key)) {
// read data from local storage:
    String job = local[key];
    querySelector('#data').appendText(job);
   }
 }

class Job {
  int id;
  String type;
  int salary;
  String company;
  Job(this.id, this.type, this.salary, this.company);
  String get toJson => '{ "type": "$type", "salary": "$salary", "company": "$company" } ';
}