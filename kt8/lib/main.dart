import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/delete_task.dart';
import 'domain/usecases/update_task.dart';
import 'presentation/bloc/task_bloc.dart';
import 'presentation/screens/task_screen.dart';

void main() {
  final repo = TaskRepositoryImpl();
  runApp(MyApp(repo));
}

class MyApp extends StatelessWidget {
  final TaskRepositoryImpl repo;
  const MyApp(this.repo, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TaskBloc(
          getTasks: GetTasks(repo),
          addTask: AddTask(repo),
          deleteTask: DeleteTask(repo),
          updateTask: UpdateTask(repo),
        )..add(LoadTasks()),
        child: TaskScreen(),
      ),
    );
  }
}