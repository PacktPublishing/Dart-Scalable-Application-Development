library store;

import 'package:postgresql/postgresql.dart';
import 'job.dart';
//
///****
// * A class to manage a list of jobs in memory
// * and PostgreSQL storage.
// */

class JobStore {
  final List<Job> jobs = new List();
  Job job;
  Connection conn;
  var uri = 'postgres://postgres:avalon@localhost:5432/jobsdb';

  // 5- opening a connection to the database:
  openAndStore() {
    connect(uri).then((_conn) {
      conn = _conn;
      storeData();
    }).catchError(print);
  }

  storeData() {
    for (job in jobs) {
      insert(job);
    }
    // 6- close the database connection:
    close();
  }

  // 7- inserting a record in a table:
  insert(Job job) {
    var jobMap = job.toMap();
    conn.execute('insert into jobs values (@dbKey, @type, @salary, @company, @posted, @open)', jobMap).then((_) {
      print('inserted');
    }).catchError(print);
  }

  openAndRead() {
    connect(uri).then((_conn) {
      conn = _conn;
      readData();
    }).catchError(print);
  }

  // 8- reading records from a table:
  readData() {
    conn.query('select * from jobs').toList().then((results) {
      processJob(results);
      close();
    });
  }

  // 9- working with record data:
  processJob(results) {
    for (var row in results) {
      // Refer to columns by nam:
      print('${row.dbKey} - ${row.type} - ${row.salary} - ${row.company} - ${row.posted} ${row.open}');
      // print(row[0]);    // Or by column index.
    }
  }

  close() {
    conn.close();
  }

  // 10- updating a record in a table:
  update(Job job) {
    var jobMap = job.toMap();
    conn.execute('update jobs set type = @type, salary = @salary, company = @company, ' 'posted = @posted, open = @open where dbKey = @dbKey', jobMap).then((_) {
      print('updated');
    }).catchError(print);
  }

  // 11- deleting a record in a table:
  delete(Job job) {
    var jobMap = job.toMap();
    conn.execute('delete from jobs where dbKey = @dbKey', jobMap).then((_) {
      print('deleted');
    }).catchError(print);
  }
}