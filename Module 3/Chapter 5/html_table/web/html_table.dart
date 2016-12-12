import 'dart:html';

TableElement table;
TableRowElement row;
TableCellElement cell;
List<Job> jobs;

void main() {
  // Find the table.
  table = querySelector('#data');
  // Insert a row at index 0, and assign that row to a variable.
  row = table.insertRow(0);
  // Insert a cell at index 0, and assign that cell to a variable.
  cell = row.insertCell(0);
  cell.text = 'cell 0-0';
  // Insert more cells with Message Cascading approach and style them.
  row.insertCell(1)
      ..text = 'cell 0-1'
      ..style.background = 'lime';
  row.insertCell(2)
      ..text = 'cell 0-2'
      ..style.background = 'red';
  // Insert a new row at the end of the table:
  row = table.insertRow(-1);
  row.insertCell(0).text = 'cell 1-0';

  // table with data coming from a List:
  var job1 = new Job("Software Developer", 7500, "Julia Computing LLC") ;
  var job2 = new Job("Web Developer", 6500, "Dart Unlimited") ;
  var job3 = new Job("Project Manager", 10500, "Project Consulting Inc.") ;
  jobs = new List<Job>();
  jobs
      ..add(job1)
      ..add(job2)
      ..add(job3);
  table = querySelector('#jobdata');
  // insert table headers:
  InsertHeaders();
  // inserting data:
  InsertData();
  print(table.rows[1].cells[1].text); // prints 7500
}

InsertHeaders() {
   row = table.insertRow(-1);
   cell = row.insertCell(0);
   cell.text = "Jobtype";
   cell.style.background = 'lightblue';
   cell = row.insertCell(1);
   cell.text = "Salary";
   cell = row.insertCell(2);
   cell.text = "Company";
   cell.style.background = 'lightblue';
}

InsertData() {
  for (var job in jobs) {
     row = table.insertRow(-1);
     cell = row.insertCell(0);
     cell.text = job.type;
     cell = row.insertCell(1);
     cell.text = (job.salary).toString();
     cell = row.insertCell(2);
     cell.text = job.company;
   }
}

class Job {
  String type;
  int salary;
  String company;
  Job(this.type, this.salary, this.company);
}