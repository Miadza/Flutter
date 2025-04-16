import 'package:flutter/material.dart';
import 'presentation/screens/todo_list/todo_list_screen.dart';
import 'data/repositories/todo_repository_impl.dart';

void main() {
  runApp(MyApp());
}

final repository = TodoRepositoryImpl(); // <-- можно передать дальше

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MVVM + Elementary', home: TodoListScreen());
  }
}
