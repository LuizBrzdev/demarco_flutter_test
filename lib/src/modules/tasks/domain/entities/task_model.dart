class TaskEntity {
  final String name;
  final String description;
  final String date;
  final bool completed;
  final String image;

  TaskEntity({
    required this.name,
    required this.description,
    required this.date,
    required this.completed,
    required this.image,
  });
}
