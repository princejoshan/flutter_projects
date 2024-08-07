import 'package:equatable/equatable.dart';
import 'package:todoapp/domain/entities/todo_task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class GetTaskEvent extends TaskEvent {
}


class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  final String filterValue;

  const DeleteTaskEvent(this.id,this.filterValue);

  @override
  List<Object?> get props => [id];
}

class ToggleTaskEvent extends TaskEvent {
  final String id;
  final String filterValue;

  const ToggleTaskEvent(this.id,this.filterValue);

  @override
  List<Object?> get props => [id];
}

class FilterTaskEvent extends TaskEvent {
  final String filterValue;

  const FilterTaskEvent(this.filterValue);

  @override
  List<Object?> get props => [filterValue];
}