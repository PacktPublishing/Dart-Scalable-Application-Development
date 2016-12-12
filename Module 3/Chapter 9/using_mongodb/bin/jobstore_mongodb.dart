library store;

import 'package:mongo_dart/mongo_dart.dart';
import 'job.dart';
//
///****
// * A class to manage a list of jobs in memory
// * and MongoDB storage.
// */
const String DEFAULT_URI = 'mongodb://127.0.0.1/';
const String DB_NAME = 'jobsdb';
const String COLLECTION_NAME = 'jobs';

class JobStore {
  final List<Job> jobs = new List();
  Job job;
  Db db;
  DbCollection jobsColl;

  JobStore() {
    // make a new database
    db = new Db('${DEFAULT_URI}${DB_NAME}');
    // make a new collection
    jobsColl = db.collection(COLLECTION_NAME);
  }

  openAndStore() {
    db.open().then((_) {
      storeData();
    }).catchError(print);
  }

  storeData() {
    for (job in jobs) {
      insert(job);
    }
  }

  // inserting a document in a collection:
  insert(Job job) {
    var jobMap = job.toMap();
    jobsColl.insert(jobMap).then((_) {
      print('inserted job: ${job.type}');
    }).catchError(print);
  }

  openAndRead() {
    db.open().then((_) {
      readData();
    }).catchError(print);
  }

  // reading documents:
  readData() {
    jobsColl.find().toList().then((jobList) {
      processJob(jobList);
    }).catchError(print);
  }

  // working with document data:
  processJob(jobList) {
    jobList.forEach((jobMap) {
      Job job = new Job.fromMap(jobMap);
      print('${job.dbKey} - ${job.type} - ${job.salary} - '
            '${job.company} - ${job.posted} ${job.open}');
    });
  }

//   updating a document:
    update(Job job) {
      var jobMap = job.toMap();
      jobsColl.update({"dbKey": jobMap["dbKey"]},jobMap).then((_) {
        print('job updated');
      }).catchError(print);
    }

// deleting a document:
    delete(Job job) {
      var jobMap = job.toMap();
      jobsColl.remove(jobMap).then((_) {
        print('job updated');
      }).catchError(print);
    }
}