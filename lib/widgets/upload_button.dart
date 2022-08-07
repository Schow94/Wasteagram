import 'package:flutter/material.dart';

import '../db/entry_dto.dart';

class UploadButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(EntryDTO) newPost;
  EntryDTO newEntry;

  UploadButton({
    Key? key,
    required this.formKey,
    required this.newPost,
    required this.newEntry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Semantics(
            button: true,
            enabled: true,
            onTapHint: 'Save new post',
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
    );
  }
}

/*
    Navigate to AddEntry Screen
  */
void goToListScreen(BuildContext context) {
  Navigator.of(context).pop('');
}
