import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_assistant_app/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
  ) submitFn;

  // AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);
  const AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      final snackBar = SnackBar(
        content: const Text('Please pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (!isValid) return;
    _formKey.currentState!.save();
    widget.submitFn(
      _userEmail.trim(),
      _userPassword.trim(),
      _userName.trim(),
      _userImageFile!,
      _isLogin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(imagePickFn: _pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                    validator: (value) {
                      if (value == null) return null;
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                      validator: (value) {
                        if (value == null) return null;
                        if (value.isEmpty || value.length < 4) {
                          return 'Enter Username of length at least 4';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                    validator: (value) {
                      if (value == null) return null;
                      if (value.isEmpty || value.length < 7) {
                        return 'Password at least be 7 length long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 12),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ElevatedButton(
                              child: Text(_isLogin ? 'Login' : 'SignUp'),
                              onPressed: _trySubmit,
                            ),
                            TextButton(
                              child: Text(_isLogin
                                  ? 'Create New Account'
                                  : 'I already have account'),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
