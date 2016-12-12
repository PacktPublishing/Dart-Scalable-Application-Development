import 'dart:html';
import '../model/job.dart';

HttpRequest req;
String serverResponse = '';

void main() {
  querySelector("#submit").onClick.listen(submitForm);
}

submitForm(e) {
  e.preventDefault(); // Don't do the default submit.
  // send data to webserver:
  req = new HttpRequest();
  req.onReadyStateChange.listen(onResponse);
  // POST the data to the server.
  var url = 'http://127.0.0.1:4040';
  req.open('POST', url);
  req.send(_jobData()); // send JSON String to server
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
  return jb.toJson();
}

void onResponse(_) {
  if (req.readyState == HttpRequest.DONE) {
    if (req.status == 200) {
    // Data saved OK.
    serverResponse = 'Server: ' + req.responseText;
    } else if (req.status == 0) {
    // Status is 0: most likely the server isn't running.
    serverResponse = 'No server';
    }
  querySelector("#resp").text = serverResponse;
  }
}