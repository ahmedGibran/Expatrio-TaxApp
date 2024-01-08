class Helper {
  /// Email validation
  static bool validateEmail(String? value) {
    RegExp regex = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value == null || value.isEmpty) {
      return false;
    } else {
      if (!regex.hasMatch(value)) {
        return false;
      } else {
        return true;
      }
    }
  }

  static String? validateNotEmpty(String? value) {
    String? validateText;
    if (value == null || value.trim().isEmpty) {
      validateText = 'validation error';
    }
    return validateText;
  }

  static bool isEmpty(Object? object) {
    if (object == null) return true;
    if (object is String) return object.isEmpty;
    if (object is List) return object.isEmpty;
    if (object is Map) return object.isEmpty;
    return false;
  }

  static bool validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 8) {
      return false;
    }
    return true;
  }
}
