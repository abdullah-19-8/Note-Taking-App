import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/note_model.dart';

final noteControllerProvider =
    StateNotifierProvider<NoteController, List<NoteModel>>((ref) {
  return NoteController();
});

class NoteController extends StateNotifier<List<NoteModel>> {
  NoteController() : super([]);

  void add(String title, String content) {
    state = [
      ...state,
      NoteModel(
        id: const Uuid().v4(),
        title: title,
        content: content,
      )
    ];
  }

  void remove(NoteModel note) {
    state = state.where((element) => element.id != note.id).toList();
  }

  void edit(NoteModel newNote) {
    state = state.map((note) {
      if (note.id == newNote.id) {
        return newNote;
      }
      return note;
    }).toList();
  }
}
