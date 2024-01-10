import 'dart:io';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';

class Constant {
  static const _uRL = "https://dev-api.expatrio.com/";
  var authModel = getIt.get<AuthModel>();

  String endPoint(String endPoint) {
    late String url;
    if (endPoint.isNotEmpty) {
      url = _uRL + endPoint.replaceAll(':id', '${authModel.userID}');
    } else {
      url = _uRL;
    }
    return url;
  }

  Map<String, String> getHttpClientHeader() {
    Map<String, String> headersMap = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer ${authModel.accessToken}'
    };
    return headersMap;
  }

  static InputDecoration kInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: const CustomColorScheme.light().primary),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
