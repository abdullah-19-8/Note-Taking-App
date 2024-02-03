import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/models/note_model.dart';

void main() {
  test('NoteController add note', () {
    final container = ProviderContainer();
    final noteController = container.read(noteControllerProvider.notifier);
    const title = 'title';
    const content = 'content';
    noteController.add(title, content);
    final notes = container.read(noteControllerProvider);
    expect(notes.length, 1);
    expect(notes.first.title, title);
    expect(notes.first.content, content);
  });

  test('NoteController remove note', () {
    final container = ProviderContainer();
    final noteController = container.read(noteControllerProvider.notifier);
    const title = 'title';
    const content = 'content';
    noteController.add(title, content);
    final notes = container.read(noteControllerProvider);
    expect(notes.length, 1);
    noteController.remove(notes.first);
    final newNotes = container.read(noteControllerProvider);
    expect(newNotes.length, 0);
  });

  test('NoteController edit note', () {
    final container = ProviderContainer();
    final noteController = container.read(noteControllerProvider.notifier);
    const title = 'title';
    const content = 'content';
    noteController.add(title, content);
    final notes = container.read(noteControllerProvider);
    final originalNote = notes.first;

    const newTitle = 'new title';
    const newContent = 'new content';
    final newNote = NoteModel(
      id: originalNote.id,
      title: newTitle,
      content: newContent,
    );

    noteController.edit(newNote);

    final editedNotes = container.read(noteControllerProvider);
    expect(editedNotes.length, 1);
    expect(editedNotes.first.title, newTitle);
    expect(editedNotes.first.content, newContent);
  });
}
