import 'dart:ui';
//import 'package:mnoteapp/view_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/blocs/notes_bloc.dart';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/home_screen.dart';
import 'package:mnoteapp/main.dart';
import 'package:mnoteapp/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database/blocs/make_note_bloc.dart';
import 'database/blocs/view_note_bloc.dart';
import 'db_tunnel.dart';


class MakeNote extends StatefulWidget {

  MakeNote({
    Key key,
    this.title
  }):super(key : key);

  final String title;
  @override
  _MakeNoteState createState() => _MakeNoteState();
}

class _MakeNoteState extends State<MakeNote> {

  MakeNoteBloc _makeNoteBloc;
  //TextEditingController _noteController = TextEditingController();
  //TextEditingController _titleController = TextEditingController();
  ///MakeNoteBloc _makeNoteBloc;

  TextEditingController noteController = TextEditingController();

  TextEditingController titleController = TextEditingController();

  void _saveNote() async{

    Note note = Note(title: titleController.text,contents: noteController.text);
    print(note.title);
    //_makeNoteBloc.NotesBloc(note);
    DBProvider.db.newNote(note);
    //_makeNoteBloc.inAddNote.add(note);
  }//Backend bk = Backend();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
            Container(
            height: 120,
            child:Stack(
            alignment: Alignment.center,
            children: <Widget>[

            Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 20),
    height:120,
    width: 600,
    decoration: BoxDecoration(
    color: Colors.pinkAccent,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
    ),
    child:Text('Take Note',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.white
    ),
    )
    ),
    ]),
          ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 20),
              height:50,
              width: MediaQuery.of(context).size.width*0.97,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: (
              TextField(
                controller: titleController,
                decoration: InputDecoration(fillColor: Colors.white,
                  border: InputBorder.none,
                  labelStyle: TextStyle(textBaseline: TextBaseline.ideographic),
                  hintText: 'Title',
                ),
              )
              ),
            ),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20),
                height:360,
                width: MediaQuery.of(context).size.width*1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: (
                    TextField(
                      controller: noteController,
                      maxLines: 10,
                      minLines:6,
                      enableSuggestions: true,
                      enableInteractiveSelection: true,
                      onTap:(){},
                      //expands: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(textBaseline: TextBaseline.ideographic),
                        hintText: 'Body',
                      ),
                    )
                ),
              ),

              SizedBox(height: 20,),

              GestureDetector(

                onTap: (){

                    _saveNote();
                    //print(title.text + body.text);


                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MyApp()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),

                  child: Text('Save',
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),
              )

            ]
          ),
        ),
      )
    );
  }
}
