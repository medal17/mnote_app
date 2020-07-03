import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mnoteapp/main_todo.dart';
import 'package:mnoteapp/todo_ui.dart';
import 'package:mnoteapp/view_note.dart';
import 'package:mnoteapp/view_todo.dart';
import 'database/blocs/todos_bloc.dart';

import 'database/blocs/view_todo_bloc.dart';
import 'db_tunnel.dart';
import 'camera.dart';
import 'make_note.dart';
import 'models/todo_model.dart';
import 'recognizer.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/blocs/notes_bloc.dart';
import 'package:mnoteapp/models/note_model.dart';
import 'package:mnoteapp/database/blocs/view_note_bloc.dart';

class Home extends StatefulWidget {
  /*NotesPage({
    Key: key,
    this.title
}): super(key:key);
  final String title;

   */
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //ScannerUtils scannerUtils;
  //String bdy;
  //final _backend = Backend();
  ///StreamController controller = Backend().;
  NotesBloc _notesBloc;
  //TodosBloc _todosBloc;

  @override
  void initState() {
    super.initState();
    _notesBloc = BlocProvider.of<NotesBloc>(context);
    /*_todosBloc = BlocProvider.of<TodosBloc>(context);*/
  }



  void _gotoNote(Note note) async{
    bool update = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> BlocProvider(
          bloc: ViewNoteBloc(),
          child: NoteViewer(
            note:note,
          ),
        ),
      ),
    );
    if(update != null){
      _notesBloc.getNotes();
    }
  }

  void _gotoTodo(Todo todo) async{
    bool updateTodo = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> BlocProvider(
          bloc: ViewTodoBloc(),
          child: TodoViewer(
            todo:todo,
          ),
        ),
      ),
    );
    if(updateTodo != null){
      //_todosBloc.getTodo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 40),
                      height: 150,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: Text(
                        'Note',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        Recognize().initState();
                      },
                      icon: Icon(Icons.camera_alt),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                    left: 328,
                    bottom: 35,
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => MainTodo()));
                      },
                      icon: Icon(Icons.calendar_today),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                    left: 18,
                    bottom: 35,
                  ),
                  Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MakeNote()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.white, width: 0.6)),
                        child: Text(
                          '+',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Varela'),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 16),
            child: Text(
              'Favourites',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.withOpacity(0.3)),
              textAlign: TextAlign.left,
            ),
          ),

          StreamBuilder<List<Note>>(
            stream: _notesBloc.notes,
            builder: (BuildContext cxt, AsyncSnapshot<List<Note>> snapshot) {
              if(snapshot.hasData){
                if(snapshot.data.length==0){
                  return Column(
                    children: <Widget>[
                      Icon(Icons.hourglass_empty),
                      Text("No notes")
                    ],
                  );
                }
                List <Note> notes =snapshot.data;
                return Container(
                  height: 200,
                  //width: MediaQuery.of(context).size.width*0.7,
                  child: ListView.builder(reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Note note =notes[index];
                      return GestureDetector(
                        onTap: (){
                          _gotoNote(note);
                        },
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.only(left: 20),
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.pink.withOpacity(0.1),
                                  ),
                                  height: 35,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 30),
                                  child: Text(
                                    note.id.toString()+note.title.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: Text(
                                    note.contents.length > 150 ? note.contents.substring(0,150).toString():note.contents,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white),
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },

                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator() ,);

            },
          )
        ],
      ),
    );
  }
}
