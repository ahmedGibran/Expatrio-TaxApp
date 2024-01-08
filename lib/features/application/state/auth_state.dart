import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  final AuthUseCases authUseCases;

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  bool get isSubmitEnabled =>
      !Helper.isEmpty(email) &&
      Helper.validateEmail(email) &&
      !Helper.isEmpty(password) &&
      Helper.validatePassword(password);

  AuthState({required this.authUseCases}) {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _emailTextController.addListener(_listenToEmailTextChange);
    _passwordTextController.addListener(_listenToPasswordTextChange);
  }

  Future<void> login() async {
    final result = await authUseCases.login(_email, _password);
    result?.fold((l) {}, (r) => {});
    notifyListeners();
  }

  void _listenToEmailTextChange() {
    final email = _emailTextController.text;
    if (email.isEmpty || _email.isEmpty) {
      notifyListeners();
    }
    _email = email;
    notifyListeners();
  }

  void _listenToPasswordTextChange() {
    final password = _passwordTextController.text;
    if (password.isEmpty || _password.isEmpty) {
      notifyListeners();
    }
    _password = password;
    notifyListeners();
  }

  @override
  void dispose() {
    _emailTextController.removeListener(_listenToEmailTextChange);
    _passwordTextController.removeListener(_listenToPasswordTextChange);
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
