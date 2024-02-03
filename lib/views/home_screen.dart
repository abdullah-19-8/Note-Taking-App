// create a stateful widget that will be our home screen and will be the first screen that the user sees when they open the app.
// it will show a list of notes and a button to add a new note.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/views/add_note_screen.dart';

import '../controllers/note_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final notes = ref.watch(noteControllerProvider);
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: ValueKey(note.id),
                onDismissed: (direction) {
                  ref.read(noteControllerProvider.notifier).remove(note);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddNoteScreen(
                          note: note,
                        );
                      }));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
