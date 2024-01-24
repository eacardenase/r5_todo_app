import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:r5_todo_app/services/auth.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.onSwitchScreen,
  });

  final void Function() onSwitchScreen;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredUserName = '';
  var _enteredPassword = '';
  var _isLoading = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      // show error message

      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() => _isLoading = true);

      final userCredentials = await AuthService.createUserWithEmailAndPassword(
        _enteredEmail,
        _enteredPassword,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'username': _enteredUserName,
        'email': _enteredEmail,
      });
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Authentication failed.',
          ),
        ),
      );

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              label: Text(
                'Email Address',
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@')) {
                return 'Please enter a valid email address';
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredEmail = newValue!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            enableSuggestions: false,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 4) {
                return "Please enter at least 4 characters";
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredUserName = newValue!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text(
                'Password',
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return 'Password must be at least 6 characters long';
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredPassword = newValue!;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          if (_isLoading) const CircularProgressIndicator(),
          if (!_isLoading)
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text(
                'Sign Up',
              ),
            ),
          if (!_isLoading)
            TextButton(
              onPressed: widget.onSwitchScreen,
              child: const Text(
                'I already have an account',
              ),
            )
        ],
      ),
    );
  }
}
