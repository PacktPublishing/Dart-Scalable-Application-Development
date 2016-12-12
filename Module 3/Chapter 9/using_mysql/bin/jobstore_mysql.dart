library store;

import 'package:sqljocky/sqljocky.dart';
import 'package:options_file/options_file.dart';
import 'job.dart';
//
///****
// * A class to manage a list of jobs in memory
// * and in MySQL storage.
// */
ConnectionPool pool;

class JobStore {
  final List<Job> jobs = new List();
  Job job;

// 5- opening a connection to the database:
  open() {
    pool = getPool(new OptionsFile('connection.options'));
  }

  ConnectionPool getPool(OptionsFile options) {
    String user = options.getString('user');
    String password = options.getString('password');
    int port = options.getInt('port', 3306);
    String db = options.getString('db');
    String host = options.getString('host', 'localhost');
    return new ConnectionPool(host: host, port: port, user: user, password: password, db: db);
  }

  storeData() {
   for (job in jobs) {
     insert(job);
   }
  }

// 6- inserting a record in a table:
insert(Job job) {
   pool.prepare('insert into jobs (dbKey, type, salary, company, posted, open) '
                'values (?, ?, ?, ?, ?, ?)').then((query) {
   var params = new List();
   params.add(job.dbKey);
   params.add(job.type);
   params.add(job.salary);
   params.add(job.company);
   params.add(job.posted);
   params.add(job.open);
   return query.execute(params);
 }).then((_) {
 }).catchError(print);
}

// 6- inserting a record in a table: variant with Map to make parameter list
// Map not necessary here
insertMap(Job job) {
  var jobMap = job.toMap();
  pool.prepare('insert into jobs (dbKey, type, salary, company, posted, open) '
             'values (?, ?, ?, ?, ?, ?)').then((query) {
  var params = new List();
  params.add(jobMap['dbKey']);
  params.add(jobMap['type']);
  params.add(jobMap['salary']);
  params.add(jobMap['company']);
  params.add(jobMap['posted']);
  params.add(jobMap['open']);
  return query.execute(params);
  }).then((_) {
  }).catchError(print);
}

  readData() {
   pool.query('select * from jobs').then((results) {
     processJob(results);
   });
  }

  processJob(results) {
   results.forEach((row) {
     print('dbKey: ${row.dbKey}, type : ${row.type}, '
           'salary: ${row.salary}, company: ${row.company}, '
           'posted: ${row.posted}, open: ${row.open}');
   });
  }

// 7- updating a record in a table:
  update(Job job) {
    pool.prepare('update jobs set type = ?, salary = ?, company = ?, posted = ?, open = ? '
                 'where dbKey = ?').then((query) {
      var params = new List();
      params.add(job.dbKey);
      params.add(job.type);
      params.add(job.salary);
      params.add(job.company);
      params.add(job.posted);
      params.add(job.open);
      return query.execute(params);
    }).then((_) {
    }).catchError(print);
  }

// 8- deleting a record in a table:
  delete(Job job) {
    var jobMap = job.toMap();
    pool.prepare('delete from jobs where dbKey = ?').then((query) {
      var params = new List();
      params.add(job.dbKey);
      return query.execute(params);
    }).then((_) {
    }).catchError(print);
  }
}