import 'dart:io';

import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';

class Constant {
  static const _uRL = "https://dev-api.expatrio.com/";
  var authModel = getIt.get<AuthModel>();

  String endPoint(String endPoint) {
    print("myAppModel : ${authModel.runtimeType}");
    print("myAppModel.user. : ${authModel.accessToken.toString()}");
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
}
