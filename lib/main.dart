import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meine_todo_application/data/models/task_model.dart';
import 'package:meine_todo_application/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:meine_todo_application/presentation/pages/page_task.dart';
import 'package:path_provider/path_provider.dart';
import 'data/repositories/task_repository.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/delete_task.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/update_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskModelAdapter());
  final taskBox = await Hive.openBox<TaskModel>('tasks');

  final taskRepository = TaskRepository(taskBox);
  runApp(MyApp(taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  MyApp(this.taskRepository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TaskCubit(
          getTasks: GetTasks(taskRepository),
          addTask: AddTask(taskRepository),
          deleteTask: DeleteTask(taskRepository),
          updateTask: UpdateTask(taskRepository),
        ),
        child: const PageTask(),
      ),
    );
  }
}
