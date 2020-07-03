import 'dart:async';

import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/models/todo_model.dart';
//import 'package:mnoteapp/todo_ui.dart';

class TodosBloc implements BlocBase{
  final _todoController = StreamController<List<Todo>>.broadcast();

  StreamSink<List<Todo>> get _inTodos=> _todoController.sink;
  Stream<List<Todo>> get todos =>_todoController.stream;

  final _addTodoController = StreamController<Todo>.broadcast();
  StreamSink<Todo> get inAddTodo => _addTodoController.sink;

  TodosBloc(){
    getTodo();

    _addTodoController.stream.listen(_handleAddTodo);
  }


  @override
  void dispose() {
    _todoController.close();
    _addTodoController.close();
  }

  void getTodo() async{
    List<Todo> todos = await DBProvider.db.getTodo();
    _inTodos.add(todos);
  }

  void _handleAddTodo(Todo todo) async{
    await DBProvider.db.newTodo(todo);
    getTodo();
  }
}