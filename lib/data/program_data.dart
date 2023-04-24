import 'package:fitness/models/exercise.dart';
import 'package:fitness/models/program.dart';
import 'package:flutter/cupertino.dart';

class ProgramData extends ChangeNotifier {
  List<Program> programList = [];
  List<Program> getProgramList() {
    return programList;
  }

  List<Exercise> joinExerciseList() {
    List<Exercise> combinedExerciseList = [];
    combinedExerciseList.addAll(preExerciseList);
    combinedExerciseList.addAll(exerciseList);
    return combinedExerciseList;
  }

  void addProgram(Program program) {
    programList.add(
        Program(name: program.name, exercises: List.from(program.exercises)));
    notifyListeners();
  }

  void deleteProgram(Program program) {
    programList.remove(program);
    notifyListeners();
  }

  void addExercise(
      Program program, String exerciseName, String reps, String sets) {
    program.exercises.add(Exercise(name: exerciseName, reps: reps, sets: sets));
    notifyListeners();
  }

  void checkOffExercise(Program program, List<Exercise> exercises, int index) {
    Exercise relevantExercise = program.exercises[index];
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  void deleteExercise(program, int exerciseIndex) {
    program.exercises.removeAt(exerciseIndex);
    notifyListeners();
  }

  List<Exercise>? getExercisesByProgramName(String programName) {
    // Find the program object with the matching name
    Program program =
        preProgramList.firstWhere((program) => program.name == programName);
    return program.exercises;
  }

  List<Program> preProgramList = [
    //Upper Body Program
    Program(name: 'Upper Body', exercises: [
      Exercise(name: 'Bench Press', reps: '8', sets: '4'),
      Exercise(name: 'Shoulder Press', reps: '10', sets: '3'),
      Exercise(name: 'Lat Pulldowns', reps: '12', sets: '3'),
      Exercise(name: 'Bicep Curls', reps: '10', sets: '3'),
      Exercise(name: 'Tricep Extensions', reps: '12', sets: '3'),
      Exercise(name: 'Pushups', reps: '15', sets: '3'),
      Exercise(name: 'Dumbbell Flyes', reps: '12', sets: '3'),
      Exercise(name: 'Seated Cable Rows', reps: '10', sets: '3')
    ]),

    //Lower Body Program
    Program(name: 'Lower Body', exercises: [
      Exercise(name: 'Squats', reps: '12', sets: '4'),
      Exercise(name: 'Deadlifts', reps: '5', sets: '3'),
      Exercise(name: 'Leg Press', reps: '12', sets: '3'),
      Exercise(name: 'Leg Curls', reps: '10', sets: '3'),
      Exercise(name: 'Calf Raises', reps: '15', sets: '3'),
      Exercise(name: 'Hip Thrusts', reps: '12', sets: '3'),
      Exercise(name: 'Lunges', reps: '10', sets: '3'),
      Exercise(name: 'Glute Bridges', reps: '15', sets: '3')
    ]),

    //Full Body Program
    Program(name: 'Full Body', exercises: [
      Exercise(name: 'Squats', reps: '12', sets: '3'),
      Exercise(name: 'Bench Press', reps: '8', sets: '4'),
      Exercise(name: 'Deadlifts', reps: '5', sets: '3'),
      Exercise(name: 'Shoulder Press', reps: '10', sets: '3'),
      Exercise(name: 'Lat Pulldowns', reps: '12', sets: '3'),
      Exercise(name: 'Bicep Curls', reps: '10', sets: '3'),
      Exercise(name: 'Tricep Extensions', reps: '12', sets: '3'),
      Exercise(name: 'Plank', reps: '30 sec', sets: '3')
    ]),
  ];

  List<Exercise> exerciseList = [];
  List<Exercise> preExerciseList = [
    Exercise(name: 'Squats', reps: '12', sets: '3'),
    Exercise(name: 'Bench Press', reps: '8', sets: '4'),
    Exercise(name: 'Deadlifts', reps: '5', sets: '3'),
    Exercise(name: 'Shoulder Press', reps: '10', sets: '3'),
    Exercise(name: 'Lat Pulldowns', reps: '12', sets: '3'),
    Exercise(name: 'Bicep Curls', reps: '10', sets: '3'),
    Exercise(name: 'Tricep Extensions', reps: '12', sets: '3'),
  ];
}
