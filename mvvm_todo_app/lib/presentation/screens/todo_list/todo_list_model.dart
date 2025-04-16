import 'package:elementary/elementary.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../../data/repositories/todo_repository.dart';

class TodoListModel extends ElementaryModel {
  final TodoRepository _repository;

  TodoListModel(this._repository);

  Future<List<TodoEntity>> fetchTodos() => _repository.getTodos();

  Future<void> addTodo(String title) => _repository.addTodo(title);
}
