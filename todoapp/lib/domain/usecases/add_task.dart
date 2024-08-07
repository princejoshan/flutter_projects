import 'package:todoapp/domain/entities/todo_task.dart';

class AddTask {
  final List<Task> tasks;

  AddTask(this.tasks);

  List<Task> call(Task task) {
    return [...tasks, task];
  }
}
