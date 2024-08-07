import 'package:todoapp/domain/entities/todo_task.dart';

class TaskRepository {
  final List<Task> _tasks = [];
  var _isTaskPending= false;

  List<Task> get tasks => List.unmodifiable(_tasks);
  bool get isTaskPending => _isTaskPending;

  void addTask(Task task) {
    _tasks.add(task);
  }

  List<Task> deleteTask(String id, {String filterValue = "all"}) {
    _tasks.removeWhere((task) => task.id == id);
    return getTaskBasedOnFilterApplied(filterValue: filterValue);
  }

  List<Task> toggleTask(String id, {String filterValue = "all"}) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] =
          _tasks[index].copyWith(isCompleted: !_tasks[index].isCompleted);
      _isTaskPending = !_tasks[index].isCompleted;
      return getTaskBasedOnFilterApplied(filterValue: filterValue);
    }
    return List.unmodifiable(_tasks);
  }

  List<Task> filterTask({String filterValue = "all"}) {
    return getTaskBasedOnFilterApplied(filterValue: filterValue);
  }

  List<Task> getTaskBasedOnFilterApplied({String filterValue = "all"}) {
    if (filterValue.toLowerCase() == 'all') {
      return List.unmodifiable(_tasks);
    } else if (filterValue.toLowerCase() == 'completed') {
      return _tasks.where((task) => task.isCompleted).toList();
    } else {
      return _tasks.where((task) => !task.isCompleted).toList(); // pending task
    }
  }
}
