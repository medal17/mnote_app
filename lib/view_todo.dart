import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mnoteapp/model.dart';
import 'package:mnoteapp/todo_dismiss_options.dart';

import 'database/blocs/bloc_provider.dart';
import 'database/blocs/todos_bloc.dart';
import 'database/blocs/view_note_bloc.dart';
import 'database/blocs/view_todo_bloc.dart';
import 'models/todo_model.dart';


class TodoViewer extends StatefulWidget {

  TodoViewer({
    Key key,
    this.todo
  }):super(key : key);

  final Todo todo;
  @override
  _TodoViewerState createState() => _TodoViewerState();
}

class _TodoViewerState extends State<TodoViewer> {

  ViewTodoBloc _viewTodoBloc;
  TextEditingController _todoController = TextEditingController();
  TextEditingController _todoTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewTodoBloc = BlocProvider.of<ViewTodoBloc>(context);
    _todoController.text = widget.todo.subTasks;
    _todoTitleController.text = widget.todo.title;
  }

  void _saveTodo() async {
    widget.todo.subTasks = _todoController.text;
    widget.todo.title = _todoTitleController.text;
    _viewTodoBloc.inSaveTodo.add(widget.todo);
  }

  void _deleteTodo() {
    _viewTodoBloc.inDeleteTodo.add(widget.todo.id);
    _viewTodoBloc.todoDeleted.listen((deleted) {
      if (deleted) {
        Navigator.of(context).pop(true);
      }
    });
  }

/*  TodosBloc _notesBloc;
  void _gotoEdit(Todo todo) async{
    bool editTodo = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> BlocProvider(
          bloc: ViewTodoBloc(),
          child: TodoEditor(
            todo:todo,
          ),
        ),
      ),
    );
    if(editTodo != null){
      _notesBloc.getTodo();
    }
  }
  */
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
                                Text('Take Note',
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
                                      /*Todo todo = Todo(id: widget.todo.id,title: widget.todo.title,subTasks: widget.todo.subTasks);
                                      _gotoEdit(todo);*/
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
                                          content: Text('Are you Sure \n You want to delete Task?'),
                                          actions: <Widget>[
                                            FlatButton(onPressed: (){_deleteTodo();}, child: Text('Yes')),
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
                  child: Text(_todoTitleController.text,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(13.0),
                  child: Text(_todoController.text,
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                ),

              ])
      ),
    );


  }
}





























