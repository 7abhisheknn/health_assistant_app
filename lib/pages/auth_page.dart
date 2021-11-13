import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  List<String> degree = ['MBBS', 'MD'];
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  Future _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    bool isDoctor,
    List<String> degree,
    List<String> specialist,
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
        await ref.putFile(image!).whenComplete(() => null);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('user')
            .doc(authResult.user!.uid)
            .set({
          'doc_id': authResult.user!.uid,
          'username': username,
          'email': email,
          'image_url': url,
          if (isDoctor) 'is_doctor': isDoctor,
          if (isDoctor) 'degree': degree,
          if (isDoctor) 'specialist': specialist
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
      // ignore: avoid_print
      print(error);
    }
    // ignore: avoid_print
    if (authResult != null) print(authResult);
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      submitFn: _submitAuthForm,
      isLoading: _isLoading,
    );
  }
}
