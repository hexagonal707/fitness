import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget child;
  final SharedAxisTransitionType transitionType;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;

  CustomPageRouteBuilder({
    required this.child,
    required this.transitionType,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          reverseTransitionDuration: reverseTransitionDuration,
          transitionDuration: transitionDuration,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType,
              child: child,
            );
          },
        );
}
