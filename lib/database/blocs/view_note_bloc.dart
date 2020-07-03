import 'dart:async';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/models/note_model.dart';

class ViewNoteBloc implements BlocBase{
  final _saveNoteController = StreamController<Note>.broadcast();
  StreamSink<Note> get inSave =>_saveNoteController.sink;
  
  final _deleteNoteController = StreamController<int>.broadcast();
  StreamSink<int> get inDeleteNote => _deleteNoteController.sink;
  
  final _notedeleteController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inDelete => _notedeleteController.sink;
  Stream<bool> get deleted => _notedeleteController.stream;
  
  ViewNoteBloc(){
    
    _saveNoteController.stream.listen(_handleSaveNote);
    _deleteNoteController.stream.listen(_handleDeleteNote);
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _deleteNoteController.close();
    _saveNoteController.close();
    _notedeleteController.close();
  }
  
  void _handleSaveNote(Note note) async{
    await DBProvider.db.updateNote(note);
  }

  void _handleDeleteNote(int id) async{
      await DBProvider.db.deleteNote(id);
      _inDelete.add(true);
  }
  
  

}