import 'package:flutter/material.dart';
import 'package:words_app/core/globals.dart';

Future hideKeyboard() async {
  Future.delayed(Duration(microseconds: 1), () {
    if (navigatorKey.currentContext != null) {
      FocusScope.of(navigatorKey.currentContext!).unfocus();
    }
  });
}
