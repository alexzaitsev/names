import 'package:flutter/material.dart';

extension Style on State {
  TextStyle h2({Color color = Colors.white}) {
    return Theme.of(context).textTheme.headline2!.copyWith(
          color: color,
          decoration: TextDecoration.none,
        );
  }

  TextStyle h4({Color color = Colors.white}) {
    return Theme.of(context).textTheme.headline4!.copyWith(
          color: color,
          decoration: TextDecoration.none,
        );
  }
}
