import 'package:flutter/material.dart';
import 'package:expatrio_tax_task/core/core.dart';

String getTranslatedValue(BuildContext context, String key) {
  return AppLocalization.of(context).getTranslatedValue(key);
}
