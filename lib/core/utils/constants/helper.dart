class Helper {
  /// Email validation
  static String? validateEmail(String? value) {
    String? validateText;
    RegExp regex = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value == null || value.isEmpty) {
      validateText = 'Email validation error';
      return validateText;
    } else {
      if (!regex.hasMatch(value)) {
        validateText = 'Email validation error';
        return validateText;
      } else {
        return validateText;
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

  static String? validatePassword(String? value) {
    String? validateText;
    if (value == null || value.isEmpty || value.length < 8) {
      validateText = 'Password validation error';
    }
    return validateText;
  }
}
