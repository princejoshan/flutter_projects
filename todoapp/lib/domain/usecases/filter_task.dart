import 'package:todoapp/domain/entities/todo_task.dart';

class FilterTask {
  final List<Task> tasks;

  FilterTask(this.tasks);

  List<Task> call(String id) {
    return tasks.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
  }
}