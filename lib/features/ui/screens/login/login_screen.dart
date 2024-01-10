import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody(),
      floatingActionButton: FloatingActionButtonBody(),
    );
  }
}
