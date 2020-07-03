import 'dart:async';
import 'package:mnoteapp/database/database.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/models/todo_model.dart';

class ViewTodoBloc implements BlocBase{
  final _saveTodoController = StreamController<Todo>.broadcast();
  StreamSink<Todo> get inSaveTodo =>_saveTodoController.sink;
  
  final _deleteTodoController = StreamController<int>.broadcast();
  StreamSink<int> get inDeleteTodo => _deleteTodoController.sink;
  
  final _todoDeleteController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inDelete => _todoDeleteController.sink;
  Stream<bool> get todoDeleted => _todoDeleteController.stream;
  
  ViewTodoBloc(){
    
    _saveTodoController.stream.listen(_handleSaveTodo);
   _deleteTodoController.stream.listen(_handleDeleteTodo);
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _deleteTodoController.close();
    _saveTodoController.close();
    _todoDeleteController.close();
  }
  
  void _handleSaveTodo(Todo todo) async{
    await DBProvider.db.updateTodo(todo);
  }

  void _handleDeleteTodo(int id) async{
      await DBProvider.db.deleteTodo(id);
      _inDelete.add(true);
  }
  
  

}