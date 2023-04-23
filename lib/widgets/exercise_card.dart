import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final String title;
  final String label1;
  final String label2;
  final void Function(bool) onCheckBoxChanged;
  const ExerciseCard({
    Key? key,
    this.padding = const EdgeInsets.all(0.0),
    this.contentPadding = const EdgeInsets.all(8.0),
    required this.title,
    required this.label1,
    required this.label2,
    required this.onCheckBoxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        child: Padding(
          padding: contentPadding,
          child: SizedBox(
            height: 116.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26.0),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Row(
                        children: <Widget>[
                          Chip(
                            shape: const StadiumBorder(),
                            label: Text(
                              label1,
                              style: const TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Chip(
                            shape: const StadiumBorder(),
                            label: Text(
                              label2,
                              style: const TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
