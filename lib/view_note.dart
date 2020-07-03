import 'package:flutter/material.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/blocs/notes_bloc.dart';
import 'package:mnoteapp/database/blocs/view_note_bloc.dart';
import 'package:mnoteapp/edit_note.dart';
import 'package:mnoteapp/models/note_model.dart';

class NoteViewer extends StatefulWidget {
  NoteViewer({
    Key key,
    this.note
}):super(key : key);

  final Note note;

  @override
  _NoteViewerState createState() => _NoteViewerState();
}

class _NoteViewerState extends State<NoteViewer> {

  ViewNoteBloc _viewNoteBloc;
  TextEditingController _noteController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewNoteBloc = BlocProvider.of<ViewNoteBloc>(context);
    _noteController.text = widget.note.contents;
    _titleController.text = widget.note.title;
  }

  void _saveNote() async{
    widget.note.contents = _noteController.text;
    widget.note.title = _titleController.text;
    _viewNoteBloc.inSave.add(widget.note);
  }

  void _deleteNote(){
    _viewNoteBloc.inDeleteNote.add(widget.note.id);
    _viewNoteBloc.deleted.listen((deleted){
      if(deleted){
        Navigator.of(context).pop(true);
      }
    });
  }

  NotesBloc _notesBloc;
  void _gotoEdit(Note note) async{
    bool edit = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> BlocProvider(
          bloc: ViewNoteBloc(),
          child: NoteEditor(
            note:note,
          ),
        ),
      ),
    );
    if(edit != null){
      _notesBloc.getNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
        child: Column(
        children: <Widget>[
        Container(
        height: 120,
        child:Stack(
        alignment: Alignment.center,
        children: <Widget>[

        Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(bottom: 10, left: 30),
    height:120,
    width: 600,
    decoration: BoxDecoration(
    color: Colors.pinkAccent,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
    ),
    child:Row(
      children: <Widget>[
        Text('Read Note',
        style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white
        ),
        ),
        SizedBox(width: 90,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: IconButton(
            color: Colors.white,
            onPressed: (){
              Note note = Note(id: widget.note.id,title: widget.note.title,contents: widget.note.contents);
              _gotoEdit(note);
            },
            icon: Icon(Icons.edit),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.5),
          child: IconButton(
            onPressed: (){
              showDialog(context: context,builder: (BuildContext contex){
                return AlertDialog(
                  content: Text('Are you Sure \n You want to delete note?'),
                  actions: <Widget>[
                    FlatButton(onPressed: (){_deleteNote();}, child: Text('Yes')),
                    SizedBox(height:20,),
                    FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('No')),
                  ],
                );
              });
            },
            color: Colors.white,
            icon: Icon(Icons.delete),
          ),
        ),
      ],
    )
    ),
    ]),
    ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(13.0),
            child: Text(_titleController.text,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(13.0),
            child: Text(_noteController.text,
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          ),

        ])
        ),
    );


  }
}
