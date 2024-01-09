import 'package:expatrio_tax_task/core/core.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  static CustomColorScheme _colorScheme = CustomColorScheme.light();

  static Brightness? _colorSchemeBrightness;

  CustomColorScheme get colors {
    if (_colorSchemeBrightness != null && _colorSchemeBrightness == brightness) {
      return _colorScheme;
    } else {
      _colorSchemeBrightness = brightness;
      return _colorScheme;
    }
  }
}
