import 'package:animations/animations.dart';
import 'package:fitness/data/program_data.dart';
import 'package:fitness/screens/home/exercise_page.dart';
import 'package:fitness/widgets/custom_page_route_builder.dart';
import 'package:fitness/widgets/program_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _programName;
  final _programNameController = TextEditingController();
  final List<ProgramData> programs = [];

  bool _isButtonActive = true;

  void updateButtonActive() {
    final isButtonActive = _programNameController.text.isNotEmpty;

    setState(
      () {
        _isButtonActive = isButtonActive;
      },
    );
  }

  void save() {
    String newProgramName = _programNameController.text;
    Provider.of<ProgramData>(context, listen: false).addProgram(newProgramName);
    setState(() {
      _programName = newProgramName;
    });
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    _programNameController.clear();
  }

  @override
  void initState() {
    super.initState();
    _programNameController.addListener(updateButtonActive);
    updateButtonActive();
  }

  @override
  void dispose() {
    super.dispose();
    _programNameController.dispose();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramData>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            automaticallyImplyLeading: false,
            title: const Text(
              'Program Dashboard',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
            ),
          ),
          body: SafeArea(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  scrolledUnderElevation: 0,
                  backgroundColor: Theme.of(context).canvasColor,
                  snap: true,
                  elevation: 0,
                  floating: true,
                  automaticallyImplyLeading: false,
                  title: Row(
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
                                return ProgramModalBottomSheet(
                                  height: 230.0,
                                  cancelFunction: () {
                                    cancel();
                                  },
                                  saveFunction: () {
                                    save();
                                  },
                                  programNameOnChanged: (value) {
                                    _programNameController.text = value;
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
                            Text('Program'),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
              body: provider.programList.isEmpty
                  ? const Center(
                      child: Text(
                        'No Workout Programs',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 26.0),
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.programList.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                    child: ProgramPage(
                                      index: index,
                                      programName: _programName,
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
                                child: ExpansionPanelList(
                                  expansionCallback: (index, isExpanded) {
                                    setState(() {
                                      this.isExpanded = !isExpanded;
                                    });
                                  },
                                  elevation: 0,
                                  children: [
                                    ExpansionPanel(
                                        backgroundColor: Colors.transparent,
                                        isExpanded: isExpanded,
                                        headerBuilder: (context, set) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 0.0,
                                                      horizontal: 16.0),
                                                  child: Text(
                                                    provider
                                                        .getProgramList()[index]
                                                        .name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Wrap(
                                                  children: <Widget>[
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .delete_outline_rounded,
                                                        color:
                                                            Colors.red.shade200,
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
                                        body: const SizedBox(
                                          height: 100,
                                          width: 10,
                                        ))
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
