import 'package:equatable/equatable.dart';
import 'package:todoapp/domain/entities/todo_task.dart';
import 'package:todoapp/utilities/appconstants.dart';

abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;
  final String? taskStatus;
  const TaskLoadSuccess(this.tasks,{this.taskStatus});

}

