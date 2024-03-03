class TaskEntity {
  final int id;
  final String name;
  final String description;
  final String date;
  final bool completed;
  final String image;

  TaskEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.completed,
    required this.image,
  });

  TaskEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? date,
    bool? completed,
    String? image,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      image: image ?? this.image,
    );
  }
}
