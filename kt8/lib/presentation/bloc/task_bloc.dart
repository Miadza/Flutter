import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/update_task.dart';

abstract class TaskEvent {}
class LoadTasks extends TaskEvent {}
class AddNewTask extends TaskEvent {
  final Task task;
  AddNewTask(this.task);
}
class DeleteTaskEvent extends TaskEvent {
  final String id;
  DeleteTaskEvent(this.id);
}
class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}

abstract class TaskState {}
class TaskInitial extends TaskState {}
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      final tasks = await getTasks();
      emit(TaskLoaded(tasks));
    });

    on<AddNewTask>((event, emit) async {
      await addTask(event.task);
      final tasks = await getTasks();
      emit(TaskLoaded(tasks));
    });

    on<DeleteTaskEvent>((event, emit) async {
      await deleteTask(event.id);
      final tasks = await getTasks();
      emit(TaskLoaded(tasks));
    });

    on<UpdateTaskEvent>((event, emit) async {
      await updateTask(event.task);
      final tasks = await getTasks();
      emit(TaskLoaded(tasks));
    });
  }
}