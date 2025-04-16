class TodoEntity {
  final int id;
  final String title;
  final bool isDone;

  TodoEntity({required this.id, required this.title, this.isDone = false});
}
