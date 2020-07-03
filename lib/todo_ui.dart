import 'package:flutter/material.dart';
import 'package:mnoteapp/database/blocs/todos_bloc.dart';
import 'package:mnoteapp/main.dart';
//import 'package:mnoteapp/main.dart';
import 'package:mnoteapp/view_todo.dart';
import 'database/blocs/make_todo_bloc.dart';
import 'database/blocs/todos_bloc.dart';
import 'database/blocs/view_todo_bloc.dart';
import 'database/database.dart';
import 'models/todo_model.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';

class TodoUi extends StatefulWidget {
  @override
  _TodoUiState createState() => _TodoUiState();
}

class _TodoUiState extends State<TodoUi> {

  TodosBloc _todosBloc;

  @override
  void initState() {
    super.initState();
    _todosBloc = BlocProvider.of<TodosBloc>(context);
    /*_todosBloc = BlocProvider.of<TodosBloc>(context);*/
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
      _todosBloc.getTodo();
    }
  }

  MakeTodoBloc _makeTodoBloc;
  //TextEditingController _noteController = TextEditingController();
  //TextEditingController _titleController = TextEditingController();
  ///MakeNoteBloc _makeNoteBloc;

  TextEditingController todoController = TextEditingController();
  TextEditingController todoTitleController = TextEditingController();

  void _saveTodo() async{

    Todo todo = Todo(title: todoTitleController.text,subTasks: todoController.text);
    print(todo.subTasks);
    DBProvider.db.newTodo(todo);
    
  }
  @override
  Widget build(BuildContext context) {

      return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(

            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                    height: 120,
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(top: 40),
                        height: 100,
                        width: 700,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),

                        child: Row(
                          children: <Widget>[
                            Container(

                                child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (_)=>MyApp()));
                                    })),
                            Text(
                              'Todo',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),

                          ],
                        ))),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 16),
                  child: Text(
                    'My List',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.withOpacity(0.3)),
                    textAlign: TextAlign.left,
                  ),
                ),

                StreamBuilder<List<Todo>>(
                  stream: _todosBloc.todos,
                  builder: (BuildContext cxt, AsyncSnapshot<List<Todo>> snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data.length==0){
                        return Column(
                          children: <Widget>[
                            Icon(Icons.hourglass_empty),
                            Text("No Todos")
                          ],
                        );
                      }
                      List <Todo> todos =snapshot.data;
                      return Container(
                        height: 100,
                        //width: MediaQuery.of(context).size.width*0.7,
                        child: ListView.builder(reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Todo todo =todos[index];
                            return GestureDetector(
                              onTap: (){
                                _gotoTodo(todo);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                margin: EdgeInsets.only(left: 20),
                                height: MediaQuery.of(context).size.height * 0.01,
                                width: MediaQuery.of(context).size.width * 0.5,
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
                                        todo.id.toString()+todo.title.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Text(
                                        todo.subTasks.length > 150 ? todo.subTasks.substring(0,150).toString():todo.subTasks,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
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
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: Icon(Icons.today),
                    focusElevation: 2,
                    splashColor: Colors.white,
                    elevation: 2,
                    onPressed: (){
                      showDialog(context: context,builder: (BuildContext context){
                        return AlertDialog(
                          content: Container(
                            height: 200,
                            width: 300,
                            child: Column(children: <Widget>[

                              Text('create a task'),
                              SizedBox(height: 20,),
                              TextField(
                                controller: todoTitleController,
                                decoration: InputDecoration(
                                labelText: 'Insert title',

                              ),
                              ),

                              TextField(
                                controller: todoController,                                decoration: InputDecoration(
                                labelText: 'Insert Description',
                              ),
                              ),
                            ],),
                          ),
                          actions: <Widget>[

                            SizedBox(height:20,),
                            FlatButton(onPressed: (){
                              _saveTodo();
                              //Navigator.push(context, MaterialPageRoute(builder: (_)=>TodoUi()));
                            }, child: Text('Save')),
                            FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('No')),
                          ],

                        );
                      });
                    },

                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }