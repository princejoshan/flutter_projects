import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/presentation/bloc/task_bloc.dart';
import 'package:todoapp/presentation/bloc/task_event.dart';
import 'package:todoapp/presentation/bloc/task_state.dart';
import 'package:todoapp/presentation/screen/add_task_screen.dart';
import 'package:todoapp/utilities/appcolors.dart';
import 'package:todoapp/utilities/appconstants.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var selectedFilterValue = "All";

  @override
  void initState() {
    super.initState();
    context
        .read<TaskBloc>()
        .add(GetTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              selectedFilterValue = value;
              context.read<TaskBloc>().add(FilterTaskEvent(value));
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Completed', 'Pending'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.sort_sharp),
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listenWhen:  (context, state) {
          return state is TaskLoadSuccess;
        },
        listener: (context,state) {
          if(state is TaskLoadSuccess) {
            if((state.taskStatus ?? "").isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:Text(state.taskStatus ?? ""),duration: Duration(seconds: 1),),);
            }
          }
        },
        builder: (context, state) {
          if (state is TaskLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedFilterValue,style: const TextStyle(fontWeight: FontWeight.bold),),
                  if (state.tasks.isEmpty)
                    const Center(child: Text("No Tasks found"))
                  else
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context,index){
                          return const Divider();
                        },
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return ListTile(
                            title: Text(task.description),
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) {
                                context
                                    .read<TaskBloc>()
                                    .add(ToggleTaskEvent(task.id,selectedFilterValue));
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<TaskBloc>()
                                    .add(DeleteTaskEvent(task.id,selectedFilterValue));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskWidget();
          },
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: const Icon(Icons.add, color: AppColors.white)),
    );
  }

  showAddTaskWidget() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AddTaskScreen(
          taskBloc: context.read<TaskBloc>(),
        );
      },
    );
  }
}
