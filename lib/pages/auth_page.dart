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
            .set(isDoctor
                ? {
                    'doc_id': authResult.user!.uid,
                    'username': username,
                    'email': email,
                    'image_url': url,
                    'is_doctor': isDoctor,
                    'degree': degree,
                    'specialist': specialist
                  }
                : {
                    'doc_id': authResult.user!.uid,
                    'username': username,
                    'email': email,
                    'image_url': url,
                    'is_doctor': isDoctor,
                    'amh': [],
                    'ams': false,
                    'amt': 'TimeOfDay(13:00)',
                    'emh': [],
                    'ems': false,
                    'emt': 'TimeOfDay(18:00)',
                    'exerciseHistory': [],
                    'exerciseStatus': false,
                    'exerciseTime': 'TimeOfDay(06:30)',
                    'mmh': [],
                    'mms': false,
                    'mmt': 'TimeOfDay(08:30)',
                    'nmh': [],
                    'nms': false,
                    'nmt': 'TimeOfDay(21:00)',
                    'sleepHistory': [],
                    'sleepStatus': false,
                    'sleepTime': 'TimeOfDay(22:30)',
                    'wakeupHistory': [],
                    'wakeupStatus': false,
                    'wakeupTime': 'TimeOfDay(06:00)',
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
