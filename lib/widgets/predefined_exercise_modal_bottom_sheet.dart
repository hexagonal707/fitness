import 'package:fitness/data/program_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_container_textfield.dart';
import 'custom_dropdown_button_formfield.dart';
import 'custom_filled_button.dart';
import 'custom_outlined_button.dart';

class PredefinedExerciseModalBottomSheet extends StatelessWidget {
  final dynamic Function(String) exerciseNameOnChanged;
  final dynamic Function(String) setsOnChanged;
  final dynamic Function(String) repsOnChanged;
  final TextEditingController? exerciseNameTextEditingController;
  final TextEditingController? setsTextEditingController;
  final TextEditingController? repsTextEditingController;
  final List<DropdownMenuItem<Object>>? items;
  final void Function()? cancelFunction;
  final void Function()? saveFunction;
  final double height;
  final void Function(Object?) onChanged;
  const PredefinedExerciseModalBottomSheet({
    Key? key,
    required this.height,
    required this.items,
    required this.exerciseNameOnChanged,
    required this.repsOnChanged,
    required this.setsOnChanged,
    this.exerciseNameTextEditingController,
    this.setsTextEditingController,
    this.repsTextEditingController,
    this.cancelFunction,
    this.saveFunction,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SizedBox(
          width: 640.0,
          height: height,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.4),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      height: 4.0,
                      width: 32.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12.0),
                  child: Row(
                    children: const <Widget>[
                      Text(
                        'Add Exercise',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24.0),
                      ),
                    ],
                  ),
                ),

                Consumer<ProgramData>(
                  builder: (context, provider, child) {
                    return CustomDropdownButtonFormField(
                      labelText: 'Exercise',
                      hintText: 'Select an Exercise',
                      padding: EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: MediaQuery.of(context).size.width * 0.35),
                      value: null,
                      items: items,
                      onChanged: onChanged,
                    );
                  },
                ), //Reps
                CustomContainerTextField(
                  onChanged: repsOnChanged,
                  controller: repsTextEditingController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  labelText: 'Reps',
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                ),

                //Sets
                CustomContainerTextField(
                  onChanged: setsOnChanged,
                  controller: setsTextEditingController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  labelText: 'Sets',
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                ),

                // Cancel Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CustomOutlinedButton(
                      onPressed: cancelFunction,
                      colorSchemeSeed: Colors.blue,
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15.0),
                      ),
                    ),

                    // Save Button
                    CustomFilledButton(
                      onPressed: saveFunction,
                      colorSchemeSeed: Colors.blue,
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 20.0, bottom: 10.0),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
