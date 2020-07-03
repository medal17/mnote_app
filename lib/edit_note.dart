import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/blocs/view_note_bloc.dart';
import 'package:mnoteapp/main.dart';
import 'package:mnoteapp/models/note_model.dart';

class NoteEditor extends StatefulWidget {
  NoteEditor({
    Key key,
    this.note
  }):super(key : key);

  final Note note;

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {

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
                                Text('Edit Note',
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
                                    onPressed: (){},
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0.5),
                                  child: IconButton(
                                    onPressed: (){
                                      _saveNote();
                                      Navigator.of(context).push(MaterialPageRoute(builder: ((_)=>MyApp())));
                                    },
                                    color: Colors.white,
                                    icon: Icon(Icons.save),
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
                  child: TextField(controller:_titleController,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.94,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(13.0),
                  child: TextField(
                    controller:_noteController,
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                    maxLines: 10,
                    minLines: 5,

                  ),
                ),

              ])
      ),
    );


  }
}
