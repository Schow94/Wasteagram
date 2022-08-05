import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import '../models/new_post_screen_arg.dart';
import '../db/entry_dto.dart';
// import '../models/entry.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  final newEntry = EntryDTO();

  File? image;
  final picker = ImagePicker();

  // Get image
  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    Reference storageReference =
        FirebaseStorage.instance.ref().child(Path.basename(image!.path));
    UploadTask uploadTask = storageReference.putFile(image!);
    // Wait for onComplete to resolve
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    print(url);
    newEntry.image = url;
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ImageWidget(image: image),
              // Image.file(image!),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(40),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Number of Wasted Items',
                          border: UnderlineInputBorder(),
                        ),
                        onSaved: (value) {
                          // Save value in state
                          newEntry.items = int.parse(value!);
                          // newEntry.image = image!;

                          // print(newEntry.items);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Stores textfields values in DTO
                          formKey.currentState!.save();
                          newPost(newEntry);
                          goToListScreen(context);
                        }
                      },
                      child: const Icon(
                        Icons.cloud_upload,
                        size: 70,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
    Navigate to AddEntry Screen
  */
void goToListScreen(BuildContext context) {
  Navigator.of(context).pop('');
}

class ImageWidget extends StatelessWidget {
  final File? image;

  const ImageWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Image.file(image!);
    }
  }
}
