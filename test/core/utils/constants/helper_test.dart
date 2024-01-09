import 'package:expatrio_tax_task/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

//flutter test test/core/utils/constants/helper_test.dart
void main(){
  group('Helper - Validators', () {
    test('validateEmail', () {
      var validation = Helper.validateEmail('');
      expect(validation, isNotNull, reason: 'validateEmail empty should pass');

      validation = Helper.validateEmail(null);
      expect(validation, isNotNull, reason: 'validateEmail on null should pass');

      validation = Helper.validateEmail('abs.com');
      expect(validation, isNotNull, reason: 'validateEmail with wrong format should pass');

      validation = Helper.validateEmail('abs2@email.com');
      expect(validation, isNull, reason: 'validateEmail with correct format should pass');
    });

    test('validatePassword', () {
      var validation = Helper.validatePassword('');
      expect(validation, isNotNull, reason: 'validatePassword empty should pass');

      validation = Helper.validatePassword(null);
      expect(validation, isNotNull, reason: 'validatePassword on null should pass');

      validation = Helper.validatePassword('1234');
      expect(validation, isNotNull, reason: 'validatePassword with less than 8 letters should pass');

      validation = Helper.validatePassword('12345678');
      expect(validation, isNull, reason: 'validatePassword with 8 or more letters should pass');
    });

    test('validateNotEmpty', () {
      String? year = '1990';
      var validation = Helper.validateNotEmpty(year);
      expect(validation, isNull, reason: 'validateNotEmpty should pass');
    });

    test('isEmpty', () {
      var validation = Helper.isEmpty('0');
      expect(validation, false, reason: 'isEmpty should pass');

      validation = Helper.isEmpty('');
      expect(validation, true, reason: 'isEmpty on String should pass');

      validation = Helper.isEmpty(null);
      expect(validation, true, reason: 'isEmpty on null should pass');

      validation = Helper.isEmpty(Map());
      expect(validation, true, reason: 'isEmpty on Map should pass');

      validation = Helper.isEmpty([]);
      expect(validation, true, reason: 'isEmpty on List should pass');
    });
  });
}