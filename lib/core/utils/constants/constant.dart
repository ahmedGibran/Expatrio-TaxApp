class Constant {
  static const _uRL = "";
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
