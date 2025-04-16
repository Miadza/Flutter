import '../../domain/entities/todo_entity.dart';
import 'todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final List<TodoEntity> _todos = [];

  @override
  Future<List<TodoEntity>> getTodos() async {
    return _todos;
  }

  @override
  Future<void> addTodo(String title) async {
    final todo = TodoEntity(id: _todos.length + 1, title: title);
    _todos.add(todo);
  }
}
