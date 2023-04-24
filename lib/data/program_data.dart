import 'package:fitness/models/exercise.dart';
import 'package:fitness/models/program.dart';
import 'package:flutter/cupertino.dart';

class ProgramData extends ChangeNotifier {
  List<Program> programList = [];
  List<Program> getProgramList() {
    return programList;
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

  List<Exercise> joinExerciseList() {
    List<Exercise> combinedExerciseList = [];
    combinedExerciseList.addAll(preExerciseList);
    combinedExerciseList.addAll(exerciseList);
    return combinedExerciseList;
  }

  int exercisesInWorkoutCount(String programName) {
    Program relevantProgram = getRelevantProgram(programName);
    return relevantProgram.exercises.length;
  }

  void addProgram(String name) {
    programList.add(Program(name: name, exercises: []));
    notifyListeners();
  }

  void addCustomExercise(String exerciseName, String reps, String sets) {
    Exercise customExercise =
        Exercise(name: exerciseName, reps: reps, sets: sets);
    exerciseList.add(customExercise);
    notifyListeners();
  }

  void addExercise(
      Program program, String exerciseName, String reps, String sets) {
    Program relevantProgram = program;

    relevantProgram.exercises
        .add(Exercise(name: exerciseName, reps: reps, sets: sets));
    notifyListeners();
  }

  void checkOffExercise(String programName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(programName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  void deleteProgram(Program program) {
    programList.remove(program);
    notifyListeners();
  }

  void deleteExercise(Program program, String exerciseName, int index) {
    int indexToDelete = index;
    for (int i = 0; i < program.exercises.length; i++) {
      if (program.exercises[i].name == exerciseName) {
        indexToDelete = i;
        break;
      }
    }
    if (indexToDelete != -1) {
      program.exercises.removeAt(indexToDelete);
    }
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
