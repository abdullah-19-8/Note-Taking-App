import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/note_model.dart';

final noteControllerProvider =
    StateNotifierProvider<NoteController, List<NoteModel>>((ref) {
  return NoteController();
});

class NoteController extends StateNotifier<List<NoteModel>> {
  NoteController() : super([]);

  void add(NoteModel note) {
    state = [...state, note];
  }

  void remove(NoteModel note) {
    state = state.where((element) => element != note).toList();
  }
}
