class Constant {
  static const _uRL = "https://dev-api.expatrio.com/";
  String endPoint(String endPoint) {
    late String url;
    if (endPoint.isNotEmpty) {
      url = _uRL + endPoint;
    } else {
      url = _uRL;
    }
    return url;
  }
}
