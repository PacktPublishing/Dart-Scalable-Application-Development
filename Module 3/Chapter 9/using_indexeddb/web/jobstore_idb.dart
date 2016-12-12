library store;

import 'dart:html';
import 'dart:async';
import 'dart:indexed_db';
import 'job.dart';

/****
 * A class to manage a list of jobs in memory
 * and in an IndexedDB.
 */
class JobStore {
  static const String JOB_STORE = 'jobStore';
  static const String TYPE_INDEX = 'type_index';
  Database _db;
  final List<Job> jobs = new List();

  Future openDB() {
    return window.indexedDB.open('JobDB', version: 1, onUpgradeNeeded: _initDb)
                           .then(_loadDB)
                           .catchError(print);
  }

  void _initDb(VersionChangeEvent e) {
    _db = (e.target as Request).result;
    var store = _db.createObjectStore(JOB_STORE, autoIncrement: true);
    store.createIndex(TYPE_INDEX, 'type', unique: false);
  }

  Future _loadDB(Database db) {
      _db = db;
      var trans = db.transaction(JOB_STORE, 'readonly');
      var store = trans.objectStore(JOB_STORE);
      var cursors = store.openCursor(autoAdvance: true).asBroadcastStream();
      cursors.listen((cursor) {
        var job = new Job.fromJson(cursor.value);
        jobs.add(job);
      });

      return cursors.length.then((_) {
        return jobs.length;
      });
    }

  Future add(Job job) {
    // create transaction and get objectstore:
    var trans = _db.transaction(JOB_STORE, 'readwrite');
    var store = trans.objectStore(JOB_STORE);
    store.add(job.toMap())// called when add completes
      .then((addedKey) {
        print(addedKey);
        job.dbKey = addedKey;
    });
    return trans.completed.then((_) {
      // called when transaction completes
      jobs.add(job);
      return job;
    });
  }

  Future update(Job job) {
      var trans = _db.transaction(JOB_STORE, 'readwrite');
      var store = trans.objectStore(JOB_STORE);
      return store.put(job.toMap());
  }

  Future remove(Job job) {
    var trans = _db.transaction(JOB_STORE, 'readwrite');
    var store = trans.objectStore(JOB_STORE);
    store.delete(job.dbKey);
    return trans.completed.then((_) {
      job.dbKey = null;
      jobs.remove(job);
    });
  }

  Future clear() {
    var trans = _db.transaction(JOB_STORE, 'readwrite');
    var store = trans.objectStore(JOB_STORE);
    store.clear();
    return trans.completed.then((_) {
      jobs.clear();
    });
  }
}