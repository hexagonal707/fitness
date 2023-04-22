class Exercise {
  final String name;
  final String reps;
  final String sets;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.reps,
    required this.sets,
    this.isCompleted = false,
  });

  Exercise copyWith({
    String? name,
    String? reps,
    String? sets,
    bool? isCompleted,
  }) {
    return Exercise(
      name: name ?? this.name,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Exercise markAsCompleted() {
    return copyWith(isCompleted: true);
  }

  Exercise markAsNotCompleted() {
    return copyWith(isCompleted: false);
  }
}
