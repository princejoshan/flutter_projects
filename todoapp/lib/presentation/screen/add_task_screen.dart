import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/entities/todo_task.dart';
import 'package:todoapp/presentation/bloc/task_bloc.dart';
import 'package:todoapp/presentation/bloc/task_event.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskBloc taskBloc;

  AddTaskScreen({super.key, required this.taskBloc});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'Enter your task here',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final task = Task(
              id: DateTime.now().toString(),
              description: _controller.text,
            );
            taskBloc.add(AddTaskEvent(task));
            _controller.clear();
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
