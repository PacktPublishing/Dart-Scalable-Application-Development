import 'dart:html';
import 'dart:indexed_db';
import 'job.dart';
import 'jobstore_idb.dart';

JobStore js;

void main() {
// 1- test if browser supports IndexedDB:
  if (!IdbFactory.supported) {
    window.alert("Sorry, this browser does not support IndexedDB");
    return;
  }
  js = new JobStore();
// 2- creating and opening the database:
  js.openDB();
  querySelector("#store").onClick.listen(storeData);
}

storeData(Event e) {
  var job = _jobData();
// 3- writing data to IndexedDB
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