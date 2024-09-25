import 'package:meine_todo_application/data/repositories/task_repository.dart';
import 'package:meine_todo_application/domain/entities/task.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  List<Task> call() {
    return repository
        .getAllTasks()
        .map((taskModel) => Task(
            id: taskModel.id,
            title: taskModel.title,
            isCompleted: taskModel.isCompleted))
        .toList();
  }
}
