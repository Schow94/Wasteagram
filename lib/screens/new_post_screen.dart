import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import '../models/new_post_screen_arg.dart';
import '../db/entry_dto.dart';
import '../widgets/new_entry_form.dart';
import '../widgets/upload_button.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  static final formKey = GlobalKey<FormState>();
  final newEntry = EntryDTO();

  File? imageURL;
  final picker = ImagePicker();

  // Get image
  void getImage() async {
    var pickedFile;

    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    imageURL = File(pickedFile!.path);

    // Assign unique name to each image
    String filename = DateTime.now().toString() + imageURL.toString();

    Reference storageReference = FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = storageReference.putFile(imageURL!);
    // Wait for onComplete to resolve
    await uploadTask;
    final url = await storageReference.getDownloadURL();

    newEntry.imageURL = url;

    setState(() {});
  }

  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    final screenargs =
        ModalRoute.of(context)?.settings.arguments as NewPostScreenArguments;
    final void Function(EntryDTO) newPost = screenargs.newPost;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wasteagram'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                NewEntryForm(
                  formKey: formKey,
                  newEntry: newEntry,
                  imageURL: imageURL,
                ),
                UploadButton(
                  formKey: formKey,
                  newPost: newPost,
                  newEntry: newEntry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
