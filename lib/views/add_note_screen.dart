// create a stateful widget that will be our add note screen and will be the screen that the user sees when they want to add a new note.
/// it will have a form with two text fields and a button to submit the form.
/// use this controller to add a new note to the list of notes.
/// final noteControllerProvider =
//     StateNotifierProvider<NoteController, List<NoteModel>>((ref) {
//   return NoteController();
// });

// class NoteController extends StateNotifier<List<NoteModel>> {
//   NoteController() : super([]);

//   void add(NoteModel note) {
//     state = [...state, note];
//   }

//   void remove(NoteModel note) {
//     state = state.where((element) => element != note).toList();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/utils/helpers.dart';

class AddNoteScreen extends ConsumerWidget {
  final NoteModel? note;
  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final state = ref.read(noteControllerProvider.notifier);

    final isEditing = note != null;

    if (isEditing) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              maxLines: 8,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final content = contentController.text;
                if (title.isNotEmpty && content.isNotEmpty && !isEditing) {
                  state.add(
                    title,
                    content,
                  );
                  Navigator.of(context).pop();
                } else if (title.isNotEmpty &&
                    content.isNotEmpty &&
                    isEditing) {
                  if (title != note!.title || content != note!.content) {
                    state.edit(
                      NoteModel(
                        id: note!.id,
                        title: title,
                        content: content,
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    showSnackBar(context, 'No changes made');
                  }
                }
              },
              child: Text(isEditing ? 'Update Note' : 'Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
