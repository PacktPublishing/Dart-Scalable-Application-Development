import 'dart:html';
import 'job.dart';
import 'jobstore_lawndart.dart';

JobStore js;

void main() {
  js = new JobStore();
// 1- creating and opening the database:
  js.open();
  // TODO:
  // add mechanism to read last dbKey and store this in Job.unique
  querySelector("#store").onClick.listen(storeData);
}

storeData(Event e) {
  var job = _jobData();
// 2- writing data to storage
  js.add(job);
}

_jobData() {
  // read out data:
  InputElement icomp, isal, iposted, iopen ;
  SelectElement itype;
  icomp = querySelector("#comp");
  itype = querySelector("#type");
  isal = querySelector("#sal");
  iposted = querySelector("#posted");
  iopen = querySelector("#open");
  var comp = icomp.value;
  var type = itype.value;
  var sal = isal.value.trim();
  var posted = DateTime.parse(iposted.value.trim());
  var open = iopen.value;
  // make Job object
  Job jb = new Job(type, int.parse(sal), comp, posted);
  // JSON encode object:
  return jb;
}