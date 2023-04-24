import 'package:animations/animations.dart';
import 'package:fitness/data/program_data.dart';
import 'package:fitness/models/exercise.dart';
import 'package:fitness/models/program.dart';
import 'package:fitness/screens/exercise/exercise_page.dart';
import 'package:fitness/widgets/custom_page_route_builder.dart';
import 'package:fitness/widgets/predefined_exercise_modal_bottom_sheet.dart';
import 'package:fitness/widgets/predefined_program_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramPage extends StatefulWidget {
  static const String id = 'home_page';
  const ProgramPage({Key? key}) : super(key: key);

  @override
  State<ProgramPage> createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  final _programNameController = TextEditingController();
  late final _exerciseNameController = TextEditingController();
  late final _setsController = TextEditingController();
  late final _repsController = TextEditingController();
  late Program _program;

  bool _isButtonActive = true;
  bool isExpanded = false;

  void updateButtonActive() {
    final isButtonActive = _programNameController.text.isNotEmpty;

    setState(
      () {
        _isButtonActive = isButtonActive;
      },
    );
  }

  void saveProgram(Program program, List<Exercise> exercise) {
    Provider.of<ProgramData>(context, listen: false).addProgram(program);
    Navigator.pop(context);
  }

  void deleteProgram(Program program) {
    Provider.of<ProgramData>(context, listen: false).deleteProgram(program);
  }

  void clearProgram() {
    _programNameController.clear();
  }

  void cancelProgram(BuildContext context) {
    Navigator.pop(context);
    clearProgram();
  }

  void clearExercise() {
    _exerciseNameController.clear();
    _repsController.clear();
    _setsController.clear();
  }

  void cancelExercise(BuildContext context) {
    Navigator.pop(context);
    clearExercise();
  }

  void saveExercise(Program program) {
    final provider = Provider.of<ProgramData>(context, listen: false);

    String newExerciseName = _exerciseNameController.text;
    String sets = _setsController.text;
    String reps = _repsController.text;
    provider.addExercise(program, newExerciseName, reps, sets);
    Navigator.pop(context);
    clearExercise();
  }

  @override
  void initState() {
    super.initState();
    updateButtonActive();
    _programNameController.addListener(updateButtonActive);
    _exerciseNameController.addListener(updateButtonActive);
    _setsController.addListener(updateButtonActive);
    _repsController.addListener(updateButtonActive);
  }

  @override
  void dispose() {
    _programNameController.dispose();
    _exerciseNameController.dispose();
    _repsController.dispose();
    _setsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramData>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      /*FilledButton(
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
                                    cancelExercise(context);
                                  },
                                  saveFunction: () {
                                    final customExerciseName =
                                        _exerciseNameController.text;
                                    final customReps = _repsController.text;
                                    final customSets = _setsController.text;
                                    saveCustomExercise(customExerciseName,
                                        customReps, customSets);
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
                            Text('Custom exercise'),
                          ],
                        ),
                      ),*/
                      const SizedBox(width: 8.0),
                      FilledButton(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text('Program'),
                          ],
                        ),
                        onPressed: () {
                          provider.preProgramList;
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
                                return PredefinedProgramModalBottomSheet(
                                  height: 236.0,
                                  cancelFunction: () {
                                    cancelProgram(context);
                                  },
                                  saveFunction: () {
                                    saveProgram(_program, _program.exercises);
                                  },
                                  item: provider.preProgramList.map(
                                    (program) {
                                      provider.preProgramList;
                                      return DropdownMenuItem(
                                        onTap: () {
                                          program.name;
                                          setState(() {
                                            _program = program;
                                          });
                                        },
                                        value: program.name,
                                        child: Text(program.name),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {},
                                );
                              });
                        },
                      ),
                    ],
                  ),
                )),
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Fitness App',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: provider.programList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'No Workout Programs',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 26.0),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            'To add a program, click on + button.',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: provider.programList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final program = provider.programList[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                CustomPageRouteBuilder(
                                    child: ExercisePage(
                                      program: program,
                                      index: index,
                                    ),
                                    transitionType:
                                        SharedAxisTransitionType.horizontal),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 0.0),
                                child: ExpansionPanelList.radio(
                                  expansionCallback: (index, isExpanded) {
                                    setState(() {
                                      this.isExpanded = !isExpanded;
                                    });
                                  },
                                  elevation: 0,
                                  children: <ExpansionPanelRadio>[
                                    ExpansionPanelRadio(
                                      value: index,
                                      backgroundColor: Colors.transparent,
                                      headerBuilder: (context, set) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0,
                                                horizontal: 16.0),
                                            child: Text(
                                              provider
                                                  .getProgramList()[index]
                                                  .name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 22.0),
                                            ),
                                          ),
                                          Wrap(
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: () {
                                                  deleteProgram(program);
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.red.shade200
                                                      : Colors.red.shade400,
                                                ),
                                              ),
                                              IconButton(
                                                  iconSize: 22.0,
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.edit_outlined,
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                      body: Column(
                                        children: [
                                          program.exercises.isEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 12.0,
                                                          right: 16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      const Text(
                                                        'Add an exercise',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14.0),
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor: Colors
                                                            .green.shade100,
                                                        child: IconButton(
                                                            color: Colors
                                                                .green.shade900,
                                                            onPressed: () {
                                                              clearExercise();
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return PredefinedExerciseModalBottomSheet(
                                                                      items: provider
                                                                          .preProgramList[
                                                                              index]
                                                                          .exercises
                                                                          .map(
                                                                            (exercise) =>
                                                                                DropdownMenuItem(
                                                                              onTap: () {
                                                                                exercise.name;
                                                                              },
                                                                              value: exercise.name,
                                                                              child: Text(exercise.name),
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                      cancelFunction:
                                                                          () {
                                                                        cancelExercise(
                                                                            context);
                                                                      },
                                                                      saveFunction:
                                                                          () {
                                                                        saveExercise(
                                                                            program);
                                                                      },
                                                                      height:
                                                                          380.0,
                                                                      exerciseNameOnChanged:
                                                                          (value) {},
                                                                      repsOnChanged:
                                                                          (value) {},
                                                                      setsOnChanged:
                                                                          (value) {},
                                                                      exerciseNameTextEditingController:
                                                                          _exerciseNameController,
                                                                      repsTextEditingController:
                                                                          _repsController,
                                                                      setsTextEditingController:
                                                                          _setsController,
                                                                      onChanged:
                                                                          (value) {
                                                                        final selectedExercise = provider
                                                                            .joinExerciseList()
                                                                            .firstWhere(
                                                                              (exercise) => exercise.name == value,
                                                                            );

                                                                        setState(
                                                                            () {
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
                                                            icon: const Icon(
                                                                Icons.add)),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              bottom: 12.0,
                                                              right: 16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Add an exercise',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14.0),
                                                          ),
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors.green
                                                                    .shade100,
                                                            child: IconButton(
                                                                color: Colors
                                                                    .green
                                                                    .shade900,
                                                                onPressed: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        /*var exercises =
                                                                            provider.getExercisesByProgramName(program.name);*/
                                                                        return PredefinedExerciseModalBottomSheet(
                                                                          items: provider
                                                                              .preProgramList[index]
                                                                              .exercises
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
                                                                          cancelFunction:
                                                                              () {
                                                                            cancelExercise(context);
                                                                          },
                                                                          saveFunction:
                                                                              () {
                                                                            saveExercise(program);
                                                                          },
                                                                          height:
                                                                              380.0,
                                                                          exerciseNameOnChanged:
                                                                              (value) {},
                                                                          repsOnChanged:
                                                                              (value) {},
                                                                          setsOnChanged:
                                                                              (value) {},
                                                                          exerciseNameTextEditingController:
                                                                              _exerciseNameController,
                                                                          repsTextEditingController:
                                                                              _repsController,
                                                                          setsTextEditingController:
                                                                              _setsController,
                                                                          onChanged:
                                                                              (value) {
                                                                            final selectedExercise =
                                                                                provider.programList[index].exercises.firstWhere((exercise) {
                                                                              return exercise.name == value;
                                                                            });

                                                                            setState(() {
                                                                              _exerciseNameController.text = selectedExercise.name;
                                                                              _repsController.text = selectedExercise.reps;
                                                                              _setsController.text = selectedExercise.sets;
                                                                            });
                                                                          },
                                                                        );
                                                                      });
                                                                },
                                                                icon: const Icon(
                                                                    Icons.add)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    ListView.builder(
                                                        itemCount: provider
                                                            .programList[index]
                                                            .exercises
                                                            .length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const ClampingScrollPhysics(),
                                                        itemBuilder: (context,
                                                            exerciseIndex) {
                                                          return Card(
                                                            elevation: 0,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0,
                                                                    right: 8.0),
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Colors
                                                                    .blueGrey
                                                                    .withOpacity(
                                                                        0.1)
                                                                : Colors.blue
                                                                    .withOpacity(
                                                                        0.1),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0,
                                                                  horizontal:
                                                                      32.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    program
                                                                        .exercises[
                                                                            exerciseIndex]
                                                                        .name,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red
                                                                            .shade100,
                                                                    child: IconButton(
                                                                        color: Colors.red.shade900,
                                                                        onPressed: () {
                                                                          provider.deleteExercise(
                                                                              program,
                                                                              exerciseIndex);
                                                                        },
                                                                        icon: const Icon(Icons.delete_outline_rounded)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
