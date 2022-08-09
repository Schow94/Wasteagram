import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/entry_dto.dart';

class NewEntryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final File? imageURL;
  final EntryDTO newEntry;

  const NewEntryForm(
      {Key? key, required this.newEntry, required this.formKey, this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageURL == null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Column(
        children: [
          Image.file(imageURL!),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25),
                    decoration: const InputDecoration(
                      labelText: 'Number of Wasted Items',
                      border: UnderlineInputBorder(),
                    ),
                    onSaved: (value) {
                      // Save value in state
                      newEntry.quantity = int.parse(value!);
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
        ],
      );
    }
  }
}
