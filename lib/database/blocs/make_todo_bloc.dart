import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/models/note_model.dart';
import 'package:mnoteapp/models/todo_model.dart';

class MakeTodoBloc implements BlocBase{
 // final _noteController = StreamController<List<Note>>.broadcast();

  //final _addNoteController = StreamController<Note>.broadcast();
  //StreamSink<Note> get inAddNote => _addNoteController.sink;


  TodoBloc(Todo todo){
    //_addNoteController.stream.listen(_handleAddNote);

    DBProvider.db.newTodo(todo);
    print(todo.subTasks);
  }


  @override
  void dispose() {
    //_noteController.close();
   // _addNoteController.close();
  }

}