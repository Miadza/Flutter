import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'todo_list_widget_model.dart';

class TodoListScreen extends ElementaryWidget<ITodoListWidgetModel> {
  const TodoListScreen({Key? key})
    : super(defaultTodoListWidgetModelFactory, key: key);

  @override
  Widget build(ITodoListWidgetModel wm) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('TODO List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    wm.onAddPressed(controller.text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: wm.todos,
              builder:
                  (_, todos, __) => ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (_, index) {
                      final todo = todos[index];
                      return ListTile(title: Text(todo.title));
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
