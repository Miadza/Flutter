import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'todo_list_model.dart';
import 'todo_list_screen.dart';
import '../../../domain/entities/todo_entity.dart';

abstract class ITodoListWidgetModel extends IWidgetModel {
  ValueNotifier<List<TodoEntity>> get todos;
  void onAddPressed(String title);
}

TodoListWidgetModel defaultTodoListWidgetModelFactory(BuildContext context) {
  return TodoListWidgetModel(TodoListModel(/* передаём репозиторий тут */));
}

class TodoListWidgetModel extends WidgetModel<TodoListScreen, TodoListModel>
    implements ITodoListWidgetModel {
  @override
  final ValueNotifier<List<TodoEntity>> todos = ValueNotifier([]);

  TodoListWidgetModel(super.model);

  @override
  void onAddPressed(String title) async {
    await model.addTodo(title);
    todos.value = await model.fetchTodos();
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.fetchTodos().then((value) => todos.value = value);
  }
}
