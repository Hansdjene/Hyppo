import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.light, // Thème clair
  scaffoldBackgroundColor: Colors.white,

  useMaterial3: true, // Correct placement of useMaterial3
);

ThemeData darkMode = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark, // Thème sombre
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true, // Correct placement of useMaterial3
);
