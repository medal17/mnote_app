import 'dart:async';

import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/models/note_model.dart';

class NotesBloc implements BlocBase{
  final _noteController = StreamController<List<Note>>.broadcast();

  StreamSink<List<Note>> get _inNotes=> _noteController.sink;
  Stream<List<Note>> get notes =>_noteController.stream;

  final _addNoteController = StreamController<Note>.broadcast();
  StreamSink<Note> get inAddNote => _addNoteController.sink;

  NotesBloc(){
    getNotes();

    _addNoteController.stream.listen(_handleAddNote);
  }


  @override
  void dispose() {
    _noteController.close();
    _addNoteController.close();
  }

  void getNotes() async{
    List<Note> notes = await DBProvider.db.getNotes();
    _inNotes.add(notes);
  }

  void _handleAddNote(Note note) async{
    await DBProvider.db.newNote(note);
    getNotes();
  }
}