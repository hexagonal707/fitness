import 'package:fitness/data/program_data.dart';
import 'package:fitness/models/program.dart';
import 'package:fitness/widgets/exercise_card.dart';
import 'package:fitness/widgets/exercise_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  static const String id = 'program_page';
  final String programName;
  final int index;
  const ExercisePage({Key? key, required this.programName, required this.index})
      : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _exerciseNameController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final List<Program> programs = [];

  bool _isButtonActive = true;

  void updateButtonActive() {
    final isButtonActive = _exerciseNameController.text.isNotEmpty;

    setState(
      () {
        _isButtonActive = isButtonActive;
      },
    );
  }

  void save() {
    String programName = widget.programName;
    String newExerciseName = _exerciseNameController.text;
    String sets = _setsController.text;
    String reps = _repsController.text;
    Provider.of<ProgramData>(context, listen: false)
        .addExercise(programName, newExerciseName, sets, reps);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    _exerciseNameController.clear();
  }

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
    super.dispose();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramData>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
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
                              return ExerciseModalBottomSheet(
                                height: 380.0,
                                cancelFunction: () {
                                  cancel();
                                },
                                saveFunction: () {
                                  save();
                                },
                                exerciseNameOnChanged: (value) {
                                  _exerciseNameController.text = value;
                                },
                                setsOnChanged: (value) {
                                  _setsController.text = value;
                                },
                                repsOnChanged: (value) {
                                  _repsController.text = value;
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
              widget.programName,
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
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
