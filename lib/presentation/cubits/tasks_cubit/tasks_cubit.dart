import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_todo_application/domain/entities/task.dart';
import 'package:meine_todo_application/domain/usecases/add_task.dart';
import 'package:meine_todo_application/domain/usecases/delete_task.dart';
import 'package:meine_todo_application/domain/usecases/get_tasks.dart';
import 'package:meine_todo_application/domain/usecases/update_task.dart';
import 'package:meine_todo_application/presentation/cubits/tasks_cubit/tasks_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;

  TaskCubit({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
  }) : super(TaskInitial());

  void fetchTasks() {
    try {
      final tasks = getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Failed to fetch tasks'));
    }
  }

  void createTask(Task task) {
    addTask(task);
    fetchTasks();
  }

  void removeTask(String id) {
    deleteTask(id);
    fetchTasks();
  }

  void modifyTask(Task task) {
    updateTask(task);
    fetchTasks();
  }
}
