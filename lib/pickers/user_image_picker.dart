import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  const UserImagePicker({Key? key, required this.imagePickFn})
      : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _storedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    // ignore: unrelated_type_equality_checks
    if (imageFile == Null) return;
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    widget.imagePickFn(_storedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
