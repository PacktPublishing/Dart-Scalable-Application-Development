part of idb_client;

class TasksDb {
  static const String TASKS_STORE = 'tasksStore';
  static const String TITLE_INDEX = 'titleIndex';

  Database _db;
  TasksStore _tasksStore;

  Database get db => _db;
  TasksStore get tasksStore => _tasksStore;

  Future open() {
    return window.indexedDB
      .open('tasksDb03',version: 1, onUpgradeNeeded: _initDb)
      .then(_loadDb);
  }

  void _initDb(VersionChangeEvent e) {
    var db = (e.target as Request).result;
    var store = db.createObjectStore(TASKS_STORE, autoIncrement: true);
    store.createIndex(TITLE_INDEX, 'title', unique: true);
  }

  Future<int> _loadDb(Database db) {
    _db = db;
    _tasksStore = new TasksStore(this);
    return _tasksStore.load();
  }
}

class TasksStore {
  static const String READ_ONLY = 'readonly';
  static const String READ_WRITE = 'readwrite';

  final TasksDb todo;
  final Tasks tasks = new Tasks();

  TasksStore(this.todo);

  bool get isEmpty => tasks.length == 0;

  Future<int> load() {
    var trans = todo.db.transaction(TasksDb.TASKS_STORE, READ_ONLY);
    var store = trans.objectStore(TasksDb.TASKS_STORE);
    var cursor = store.openCursor(autoAdvance: true).asBroadcastStream();
    cursor.listen((cursor) {
      var task = new Task.fromDb(cursor.key, cursor.value);
      tasks.add(task);
    });
    return cursor.length
      .then((_) {
        return tasks.length;
      });
  }

  Tasks _integrateDataFromServer(List<Map> jsonList) {
    var serverTasks = new Tasks.fromJson(jsonList);
    var clientTasks = tasks.copy();
    var clientTaskList = clientTasks.toList();
    for (var clientTask in clientTaskList) {
      if (!serverTasks.contains(clientTask.title)) {
        clientTasks.remove(clientTask);
      }
    }
    for (var serverTask in serverTasks) {
      if (clientTasks.contains(serverTask.title)) {
        var clientTask = clientTasks.find(serverTask.title);
        if (clientTask.updated.millisecondsSinceEpoch <
            serverTask.updated.millisecondsSinceEpoch) {
          clientTask.completed = serverTask.completed;
          clientTask.updated = serverTask.updated;
        }
      } else {
        clientTasks.add(serverTask);
      }
    }
    return clientTasks;
  }

  Future loadDataFromServer(List<Map> jsonList) {
    Completer completer = new Completer();
    Tasks integratedTasks = _integrateDataFromServer(jsonList);
    clear()
      .then((_) {
        int count = 0;
        for (Task task in integratedTasks) {
          addTask(task)
            .then((_) {
              if (++count == integratedTasks.length) {
                completer.complete();
              }
            });
        }
      });
    return completer.future;
  }

  Future<Task> addTaskMap(Map taskMap) {
    Task task;
    var trans = todo.db.transaction(TasksDb.TASKS_STORE, READ_WRITE);
    var store = trans.objectStore(TasksDb.TASKS_STORE);
    var future = store.add(taskMap)
      .then((addedKey) {
        task = new Task.fromDb(addedKey, taskMap);
        tasks.add(task);
      });
    return future
      .then((_) {
        return task;
      });
  }

  Future<Task> add(String title) {
    var task = new Task(title);
    var taskMap = task.toJson();
    return addTaskMap(taskMap);
  }

  Future<Task> addTask(Task task) {
    var taskMap = task.toJson();
    return addTaskMap(taskMap);
  }

  Future update(Task task) {
    var taskMap = task.toJson();
    var trans = todo.db.transaction(TasksDb.TASKS_STORE, READ_WRITE);
    var store = trans.objectStore(TasksDb.TASKS_STORE);
    return store.put(taskMap, task.key);
  }

  Future<Task> find(String title) {
    var trans = todo.db.transaction(TasksDb.TASKS_STORE, READ_ONLY);
    var store = trans.objectStore(TasksDb.TASKS_STORE);
    var future = store.index(TasksDb.TITLE_INDEX).get(title);
    return future
      .then((taskMap) {
        return new Task.fromJson(taskMap);
      });
  }

  Future complete() {
    var futureList = new List<Future>();
    for (var task in tasks) {
      if (!task.completed) {
        task.completed = true;
        task.updated = new DateTime.now();
        futureList.add(update(task));
      }
    }
    return Future.wait(futureList);
  }

  Future remove(Task task) {
    var trans = todo.db.transaction(TasksDb.TASKS_STORE, READ_WRITE);
    var store = trans.objectStore(TasksDb.TASKS_STORE);
    store.delete(task.key);
    return trans.completed
      .then((_) {
        task.key = null;
        tasks.remove(task);
      });
  }

  Future removeCompleted() {
    Completer completer = new Completer();
    int count = 0;
    Tasks completedTasks = tasks.completed;
    int completedLength = completedTasks.length;
    for (var task in completedTasks) {
      remove(task)
        .then((_) {
          if (++count == completedLength) {
            completer.complete();
          }
        });
    }
    return completer.future;
  }

  Future clear() {
    var trans = todo.db.transaction(TasksDb.TASKS_STORE, READ_WRITE);
    var store = trans.objectStore(TasksDb.TASKS_STORE);
    store.clear();
    return trans.completed
      .then((_) {
        tasks.clear();
      });
  }
}