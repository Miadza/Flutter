import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/task_bloc.dart';
import '../../domain/entities/task.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'New Task'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final task = Task(id: uuid.v4(), title: controller.text);
                context.read<TaskBloc>().add(AddNewTask(task));
                controller.clear();
              },
              child: const Text('Add Task'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoaded) {
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _showEditDialog(context, task),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Task task) {
    final controller = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedTitle = controller.text;
              if (updatedTitle.isNotEmpty) {
                final updatedTask = task.copyWith(title: updatedTitle);
                context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}