import 'exercise.dart';

class Program {
  final String name;
  final List<Exercise> exercises;

  Program({required this.name, required this.exercises});

  Program copyWith({String? name, List<Exercise>? exercises}) {
    return Program(
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }

  Program clearExercises() {
    return copyWith(exercises: []);
  }
}
