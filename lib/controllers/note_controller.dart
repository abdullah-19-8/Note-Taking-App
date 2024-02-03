import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/note_model.dart';

// Provider for managing note data using StateNotifier
final noteControllerProvider =
    StateNotifierProvider<NoteController, List<NoteModel>>((ref) {
  return NoteController();
});

class NoteController extends StateNotifier<List<NoteModel>> {
  NoteController() : super([]);

  /// Add a new note with a unique ID
  void add(String title, String content) {
    state = [
      ...state,
      NoteModel(
        id: const Uuid().v4(), // Generate unique ID using the uuid package
        title: title,
        content: content,
      )
    ];
  }

  /// Remove a note by ID
  void remove(NoteModel note) {
    state = state.where((element) => element.id != note.id).toList();
  }

  /// Edit an existing note by ID
  void edit(NoteModel newNote) {
    state = state.map((note) {
      if (note.id == newNote.id) {
        return newNote; // Replace with updated note
      }
      return note; // Keep existing note
    }).toList();
  }
}
