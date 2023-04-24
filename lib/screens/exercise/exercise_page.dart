import 'package:fitness/data/program_data.dart';
import 'package:fitness/widgets/exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/program.dart';
import '../../widgets/predefined_exercise_modal_bottom_sheet.dart';

class ExercisePage extends StatefulWidget {
  static const String id = 'program_page';
  final Program program;
  final int index;
  const ExercisePage({Key? key, required this.program, required this.index})
      : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _exerciseNameController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();

  bool _isButtonActive = true;
  bool isExpanded = false;

  void updateButtonActive() {
    final isButtonActive = _exerciseNameController.text.isNotEmpty;

    setState(
      () {
        _isButtonActive = isButtonActive;
      },
    );
  }

  void saveExercise() {
    Program program = widget.program;
    String newExerciseName = _exerciseNameController.text;
    String sets = _setsController.text;
    String reps = _repsController.text;
    Provider.of<ProgramData>(context, listen: false)
        .addExercise(program, newExerciseName, reps, sets);
    Navigator.pop(context);
    clearExercise();
  }

  void cancelExercise(context) {
    Navigator.pop(context);
    clearExercise();
  }

  void clearExercise() {
    _exerciseNameController.clear();
    _repsController.clear();
    _setsController.clear();
  }

  /*void onCheckboxChanged(Program program, Exercise exercise) {
    final provider = Provider.of<ProgramData>(context, listen: false);
    provider.checkOffExercise(program, widget.program.exercise[widget.index]);
  }*/

  @override
  void initState() {
    super.initState();
    _exerciseNameController.addListener(updateButtonActive);
    _setsController.addListener(updateButtonActive);
    _repsController.addListener(updateButtonActive);
    updateButtonActive();
  }

  @override
  void dispose() {
    _exerciseNameController.dispose();
    _repsController.dispose();
    _setsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramData>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FilledButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28.0),
                                topRight: Radius.circular(28.0),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return PredefinedExerciseModalBottomSheet(
                                items: provider
                                    .preProgramList[widget.index].exercises
                                    .map(
                                      (exercise) => DropdownMenuItem(
                                        onTap: () {
                                          exercise.name;
                                        },
                                        value: exercise.name,
                                        child: Text(exercise.name),
                                      ),
                                    )
                                    .toList(),
                                cancelFunction: () {
                                  cancelExercise(context);
                                },
                                saveFunction: () {
                                  saveExercise();
                                },
                                height: 380.0,
                                exerciseNameOnChanged: (value) {
                                  _exerciseNameController.text = value;
                                },
                                repsOnChanged: (value) {
                                  _repsController.text = value;
                                },
                                setsOnChanged: (value) {
                                  _setsController.text = value;
                                },
                                exerciseNameTextEditingController:
                                    _exerciseNameController,
                                repsTextEditingController: _repsController,
                                setsTextEditingController: _setsController,
                                onChanged: (value) {
                                  final selectedExercise =
                                      provider.joinExerciseList().firstWhere(
                                            (exercise) =>
                                                exercise.name == value,
                                          );

                                  setState(() {
                                    _exerciseNameController.text =
                                        selectedExercise.name;
                                    _repsController.text =
                                        selectedExercise.reps;
                                    _setsController.text =
                                        selectedExercise.sets;
                                  });
                                },
                              );
                            });
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text('Exercise'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            title: Text(
              widget.program.name,
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
          ),
          body: SafeArea(
            child: provider.programList[widget.index].exercises.isEmpty
                ? const Center(
                    child: Text(
                      'No Exercises',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26.0),
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        provider.programList[widget.index].exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExerciseCard(
                        onCheckBoxChanged: (value) {
                          /*onCheckboxChanged;*/
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        title: provider
                            .programList[widget.index].exercises[index].name,
                        label1:
                            '${provider.programList[widget.index].exercises[index].reps} reps',
                        label2:
                            '${provider.programList[widget.index].exercises[index].sets} sets',
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
