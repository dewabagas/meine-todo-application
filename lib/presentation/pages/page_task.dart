import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_todo_application/domain/entities/task.dart';
import 'package:meine_todo_application/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:meine_todo_application/presentation/cubits/tasks_cubit/tasks_state.dart';

class PageTask extends StatelessWidget {
  const PageTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            context.read<TaskCubit>().fetchTasks();
            return CircularProgressIndicator();
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<TaskCubit>().modifyTask(
                            Task(
                              id: task.id,
                              title: task.title,
                              isCompleted: value ?? false,
                            ),
                          );
                    },
                  ),
                  onLongPress: () =>
                      context.read<TaskCubit>().removeTask(task.id),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final task = Task(id: DateTime.now().toString(), title: 'New Task');
          context.read<TaskCubit>().createTask(task);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
