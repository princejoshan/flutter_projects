import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/repositories/task_repository.dart';
import 'package:todoapp/domain/entities/todo_task.dart';
import 'package:todoapp/presentation/bloc/task_event.dart';
import 'package:todoapp/presentation/bloc/task_state.dart';
import 'package:todoapp/utilities/appconstants.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInitial()) {
    on<GetTaskEvent>((event, emit) {
      emit(TaskLoadSuccess(taskRepository.tasks));
    });

    on<AddTaskEvent>((event, emit) {
      taskRepository.addTask(event.task);
      emit(TaskLoadSuccess(taskRepository.tasks,taskStatus:  Status.added.asString));
    });

    on<DeleteTaskEvent>((event, emit) {
      List<Task> tasks = taskRepository.deleteTask(event.id,filterValue: event.filterValue);
      emit(TaskLoadSuccess(tasks,taskStatus:  Status.deleted.asString));
    });

    on<ToggleTaskEvent>((event, emit) {
      List<Task> tasks = taskRepository.toggleTask(event.id,filterValue: event.filterValue);
      Status taskStatus;
      if(taskRepository.isTaskPending == true) {
        taskStatus = Status.pending;
      }
      else {
        taskStatus = Status.completed;
      }
      emit(TaskLoadSuccess(tasks,taskStatus: taskStatus.asString));
    });

    on<FilterTaskEvent>((event, emit) {
      List<Task> filteredTask = taskRepository.filterTask(filterValue: event.filterValue);
      emit(TaskLoadSuccess(filteredTask));
    });
  }
}