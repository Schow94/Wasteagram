/*
  - Class to help pass newPost as a Navigator arg
*/
import 'package:project5/db/entry_dto.dart';

// import '../models/entry.dart';

class NewPostScreenArguments {
  final void Function(EntryDTO) newPost;

  NewPostScreenArguments({required this.newPost});
}
