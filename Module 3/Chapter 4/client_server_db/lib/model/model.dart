part of shared_model;

class Task {
  String title;
  bool completed = false;
  DateTime updated = new DateTime.now();
  var key;

  Task(this.title);

  Task.fromDb(this.key, Map value):
    title = value['title'],
    updated = DateTime.parse(value['updated']),
    completed = value['completed'] == 'true' {
  }

  Task.fromJson(Map value):
    title = value['title'],
    updated = DateTime.parse(value['updated']),
    completed = value['completed'] == 'true' {
  }

  Map toJson() {
    return {
      'title': title,
      'completed': completed.toString(),
      'updated': updated.toString()
    };
  }

  /**
   * Compares two tasks based on title.
   * If the result is less than 0 then the first task is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Task task) {
    if (title != null) {
      return title.compareTo(task.title);
    }
  }

  /**
   * Returns a string that represents this task.
   */
  String toString() {
    return '${title}';
  }

  display() {
    print(toString);
  }
}

class Tasks {
  var _tasks = new List<Task>();

  Tasks();

  Tasks.fromJson(List<Map> jsonList) {
    for (var taskMap in jsonList) {
      add(new Task.fromJson(taskMap));
    }
  }

  Iterator<Task> get iterator => _tasks.iterator;

  int get length => _tasks.length;

  Tasks get completed {
    var completed = new Tasks();
    for (var task in _tasks) {
      if (task.completed) {
        completed.add(task);
      }
    }
    return completed;
  }

  Tasks get active {
    var active = new Tasks();
    for (var task in _tasks) {
      if (!task.completed) {
        active.add(task);
      }
    }
    return active;
  }


  List<Task> toList() => _tasks.toList();

  sort() {
    _tasks.sort((m,n) => m.compareTo(n));
  }

  bool contains(String title) {
    if (title != null) {
      for (var task in _tasks) {
        if (task.title == title) {
          return true;
        }
      }
    }
    return false;
  }

  Task find(String title) {
    if (title != null) {
      for (var task in _tasks) {
        if (task.title == title) {
          return task;
        }
      }
    }
  }

  bool add(Task task) {
    if (contains(task.title)) {
      return false;
    } else {
      _tasks.add(task);
      return true;
    }
  }

  bool remove(Task task) {
    return _tasks.remove(task);
  }

  Tasks copy() {
    var copy = new Tasks();
    for (var task in this) {
      copy.add(task);
    }
    return copy;
  }

  clear() => _tasks.clear();

  display() {
    _tasks.forEach((t) {
      t.display();
    });
  }

  List<Map> toJson() {
    var list = new List<Map>();
    for (var task in _tasks) {
      list.add(task.toJson());
    }
    return list;
  }

  String toJsonString() {
    return JSON.encode(toJson());
  }
}
