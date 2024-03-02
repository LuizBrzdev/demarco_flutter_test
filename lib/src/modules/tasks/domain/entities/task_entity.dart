class TaskEntity {
  final int id;
  final String name;
  final String description;
  final String date;
  final bool completed;
  final String image;

  TaskEntity(
    this.id, {
    required this.name,
    required this.description,
    required this.date,
    required this.completed,
    required this.image,
  });
}
