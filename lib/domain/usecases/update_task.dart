import 'package:meine_todo_application/data/models/task_model.dart';
import 'package:meine_todo_application/data/repositories/task_repository.dart';
import 'package:meine_todo_application/domain/entities/task.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  void call(Task task) {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
    repository.updateTask(taskModel);
  }
}
