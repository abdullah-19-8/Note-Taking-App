import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/utils/helpers.dart';

class AddNoteScreen extends ConsumerWidget {
  final NoteModel? note;
  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  static const routeName = '/add-note';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers for text fields
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    // Access note controller from provider
    final state = ref.read(noteControllerProvider.notifier);

    // Form key for validation
    final key = GlobalKey<FormState>();

    // Focus nodes for managing focus
    final titleFocus = FocusNode();
    final contentFocus = FocusNode();

    // Flag indicating editing mode
    final isEditing = note != null;

    if (isEditing) {
      // Pre-fill fields if editing an existing note
      titleController.text = note!.title;
      contentController.text = note!.content;
    }

    /// Handle form submission
    void submit() {
      if (key.currentState!.validate()) {
        if (isEditing) {
          // Edit existing note if changes were made
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
          // Add new note
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
                  focusNode: titleFocus,
                  onFieldSubmitted: (value) {
                    titleFocus.unfocus();
                    FocusScope.of(context).requestFocus(contentFocus);
                  },
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
                  focusNode: contentFocus,
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
                  onPressed: submit,
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
