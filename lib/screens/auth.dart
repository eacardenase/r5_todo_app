import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:r5_todo_app/widgets/auth/login_form.dart';
import 'package:r5_todo_app/widgets/auth/signup_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;

  void _switchScreen() {
    setState(() => _isLogin = !_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = LoginForm(onSwitchScreen: _switchScreen);

    if (!_isLogin) {
      mainContent = SignUpForm(onSwitchScreen: _switchScreen);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
              child: Card(
            margin: const EdgeInsets.all(
              20,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: mainContent,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
