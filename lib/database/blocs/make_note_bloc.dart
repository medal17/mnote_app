import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/models/note_model.dart';

class MakeNoteBloc implements BlocBase{
 // final _noteController = StreamController<List<Note>>.broadcast();

  //final _addNoteController = StreamController<Note>.broadcast();
  //StreamSink<Note> get inAddNote => _addNoteController.sink;


  NotesBloc(Note note){
    //_addNoteController.stream.listen(_handleAddNote);

    DBProvider.db.newNote(note);
    print(note.contents);
  }


  @override
  void dispose() {
    //_noteController.close();
   // _addNoteController.close();
  }

}