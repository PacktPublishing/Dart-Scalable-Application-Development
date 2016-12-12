library store;

import 'dart:async';
import 'package:lawndart/lawndart.dart';
import 'job.dart';

/****
 * A class to manage a list of jobs in memory
 * and in client storage (IndexedDB, WebSQL or browser local storage).
 */
class JobStore {
  static const String JOB_DB = 'jobDb';
  static const String JOB_STORE = 'jobStore';
  final List<Job> jobs = new List();
  var _store = new Store(JOB_DB, JOB_STORE);

  Future open() {
    return _store.open().then(_loadDB).catchError(print);
  }

  _loadDB(_) {
    Stream dataStream = _store.all();
    return dataStream.forEach((dbjob) {
      var job = new Job.fromJson(dbjob);
      jobs.add(job);
    });
  }

  add(Job job) {
    _store.save(job.toMap(), job.dbKey.toString()).then((addedKey) {
      jobs.add(job);
    });
  }

  Future update(Job job) {
    return _store.save(job.toMap(), job.dbKey.toString());
  }

  Future remove(Job job) {
    return _store.removeByKey(job.dbKey.toString());
  }

  clear() {
    _store.nuke().then((_) {
      jobs.clear();
    });
  }
}
