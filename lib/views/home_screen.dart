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
        title: const Text('Note Page'),
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
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddNoteScreen(note: note),
                            ),
                          );
                        },
                      )),
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
