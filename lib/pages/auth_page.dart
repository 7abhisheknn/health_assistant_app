import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
  ) async {
    UserCredential? authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(image).whenComplete(() => null);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
    } on Exception catch (e) {
      var message = 'An error occurred , please check your credentials!';
      message = e.toString();
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
    if (authResult != null) print(authResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(
        submitFn: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
