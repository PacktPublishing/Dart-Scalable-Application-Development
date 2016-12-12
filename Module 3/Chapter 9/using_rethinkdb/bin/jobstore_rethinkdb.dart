library store;

import 'package:rethinkdb_driver/rethinkdb_driver.dart';
import 'job.dart';
//
///****
// * A class to manage a list of jobs in memory
// * and RethinkDB storage.
// */

class JobStore {
  final List<Job> jobs = new List();
  Job job;
  Rethinkdb rdb = new Rethinkdb();
  Connection conn;

  // opening a connection to the database:
  openAndStore() {
    rdb.connect(db: "jobsdb", port:8000, host: "127.0.0.1").then((_conn) {
       conn = _conn;
       storeData(conn);
    }).catchError(print);
  }

  storeData(conn) {
    List jobsMap = new List();
    for (job in jobs) {
      var jobMap = job.toMap();
      jobsMap.add(jobMap);
    }
    // storing data:
    rdb.table("jobs").insert(jobsMap).run(conn)
                     .then((response)=>print('documents inserted'))
                     .catchError(print);
    // close the database connection:
    close();
  }

  openAndRead() {
    rdb.connect(db: "jobsdb", port:8000, host: "127.0.0.1").then((_conn) {
           conn = _conn;
           readData(conn);
    }).catchError(print);
  }

  // reading documents:
  readData(conn) {
    rdb.table("jobs").getAll("1,2,3").run(conn).then((results) {
      processJob(results);
      close();
    });
  }

  // working with document data:
  processJob(results) {
    for (var row in results) {
      // Refer to columns by nam:
      print('${row.dbKey} - ${row.type} - ${row.salary} - ${row.company} - ${row.posted} ${row.open}');
    }
  }

  close() {
    conn.close();
  }

  // updating a document:
  update(Job job) {
    rdb.table("jobs").update({"dbKey":job.dbKey})
       .run(conn).then((response)=>print('document updated')
    ).catchError(print);
  }

  // deleting a document:
  delete(Job job) {
    rdb.table("jobs").get(job.dbKey).delete()
       .run(conn).then((response)=>print('document deleted')
    ).catchError(print);
  }
}