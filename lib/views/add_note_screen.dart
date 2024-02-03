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
    final key = GlobalKey<FormState>();

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
        child: Form(
          key: key,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a content';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      if (isEditing) {
                        if (note?.title != titleController.text ||
                            note?.content != contentController.text) {
                          state.edit(
                            NoteModel(
                              id: note!.id,
                              title: titleController.text,
                              content: contentController.text,
                            ),
                          );
                          showSnackBar(
                            context,
                            'Note edited successfully',
                            isError: false,
                          );
                          Navigator.of(context).pop();
                        } else {
                          showSnackBar(
                            context,
                            'No changes made',
                            isError: true,
                          );
                        }
                      } else {
                        state.add(
                          titleController.text,
                          contentController.text,
                        );
                        showSnackBar(
                          context,
                          'Note added successfully',
                          isError: false,
                        );
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Text(isEditing ? 'Edit Note' : 'Add Note'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
