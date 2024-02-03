import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/utils/helpers.dart';
import 'package:note_taking_app/widgets/note_card.dart';

import '../controllers/note_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

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
                  showSnackBar(
                    context,
                    'Note deleted successfully',
                    isError: false,
                  );
                },
                child: NoteCard(note: note),
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
