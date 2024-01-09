import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';

enum AuthProviderState { init, loading, error, success }

class AuthState extends ChangeNotifier {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  final AuthUseCases authUseCases;
  AuthProviderState _state = AuthProviderState.init;

  String _email = '';
  String _password = '';
  bool _passwordVisible = false;

  String get email => _email;
  String get password => _password;
  bool get passwordVisible => _passwordVisible;

  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  AuthProviderState get state => _state;

  bool get isSubmitEnabled =>
      !Helper.isEmpty(email) &&
      Helper.validateEmail(email) == null &&
      !Helper.isEmpty(password) &&
      Helper.validatePassword(password) == null;

  AuthState({required this.authUseCases}) {
    _emailTextController = TextEditingController(text: 'tito+bs792@expatrio.com');
    _passwordTextController = TextEditingController(text: 'nemampojma');
    _emailTextController.addListener(_listenToEmailTextChange);
    _passwordTextController.addListener(_listenToPasswordTextChange);
  }

  Future<void> login() async {
    _state = AuthProviderState.loading;
    notifyListeners();
    final result = await authUseCases.login(_email, _password);
    result?.fold((l) {
      print("left: ${l}");
      _state = AuthProviderState.error;
    }, (r) {
      print("r: ${r}");
      _state = AuthProviderState.success;
    });
    notifyListeners();
  }

  void setPasswordVisible(bool visible) {
    _passwordVisible = visible;
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
