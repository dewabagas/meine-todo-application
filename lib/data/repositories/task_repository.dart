import 'package:hive/hive.dart';
import 'package:meine_todo_application/data/models/task_model.dart';

class TaskRepository {
  final Box<TaskModel> taskBox;

  TaskRepository(this.taskBox);

  List<TaskModel> getAllTasks() {
    return taskBox.values.toList();
  }

  void addTask(TaskModel task) {
    taskBox.put(task.id, task);
  }

  void deleteTask(String id) {
    taskBox.delete(id);
  }

  void updateTask(TaskModel task) {
    task.save();
  }
}
