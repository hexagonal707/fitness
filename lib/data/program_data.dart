import 'package:fitness/models/exercise.dart';
import 'package:fitness/models/program.dart';
import 'package:flutter/cupertino.dart';

class ProgramData extends ChangeNotifier {
  List<Program> programList = [];

  List<Program> getProgramList() {
    return programList;
  }

  int exercisesInWorkoutCount(String programName) {
    Program relevantProgram = getRelevantProgram(programName);
    return relevantProgram.exercises.length;
  }

  void addProgram(String name) {
    programList.add(Program(name: name, exercises: []));
    notifyListeners();
  }

  void addExercise(
      String programName, String exerciseName, String sets, String reps) {
    Program relevantProgram = getRelevantProgram(programName);

    relevantProgram.exercises
        .add(Exercise(name: exerciseName, sets: sets, reps: reps));
    notifyListeners();
  }

  void checkOffExercise(String programName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(programName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  void deleteProgram(String programName) {
    programList.removeWhere((program) => program.name == programName);
    notifyListeners();
  }

  void deleteExercise(String programName, String exerciseName) {
    Program relevantProgram = getRelevantProgram(programName);
    relevantProgram.exercises
        .removeWhere((exercise) => exercise.name == exerciseName);
    notifyListeners();
  }

  void clearExercises(String programName) {
    Program relevantProgram = getRelevantProgram(programName);
    Program updatedProgram = relevantProgram.clearExercises();
    programList[programList.indexOf(relevantProgram)] = updatedProgram;
    notifyListeners();
  }

  Program getRelevantProgram(String programName) {
    Program relevantProgram =
        programList.firstWhere((program) => program.name == programName);
    return relevantProgram;
  }

  Exercise getRelevantExercise(String programName, String exerciseName) {
    Program relevantProgram = getRelevantProgram(programName);

    Exercise relevantExercise = relevantProgram.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
