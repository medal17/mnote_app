import 'dart:io';
import 'package:mnoteapp/models/note_model.dart';
import 'package:mnoteapp/models/todo_model.dart';
//import 'package:mnoteapp/todo_ui.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future <Database> get database async{
    if(_database !=null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'app.db');

    return await openDatabase(path,version: 1,onOpen: (db) async{
    }, onCreate: (Database db, int version) async{
      await db.execute('''
            CREATE TABLE note(
                id INTEGER PRIMARY KEY,
                title TEXT,
                contents TEXT
            )
      ''');
      await db.execute('''
            CREATE TABLE todo(
                id INTEGER PRIMARY KEY,
                title TEXT,
                subTasks TEXT
            )
      ''');
    });
  }

  newNote(Note note) async {
    final db = await database;
    var query = await db.insert('note', note.toJson());
    if(query>0){print('done');}else{print('ouuch');}
    return query;

  }

  newTodo(Todo todo) async {
    final db = await database;
    var query = await db.insert('todo', todo.toJson());
    if(query>0){print('done');}else{print('ouuch');}
    return query;

  }

  getNotes() async{
    final db = await database;
    var query = await db.query('note');
    List<Note> notes = query.isNotEmpty ? query.map((note)=> Note.fromJson(note)).toList()  :[];
    return notes;
  }

  getTodo() async{
    final db = await database;
    var query = await db.query('todo');
    List<Todo> myTodo = query.isNotEmpty ? query.map((todo)=> Todo.fromJson(todo)).toList()  :[];
    return myTodo;
  }

  getSingleNote(int id) async{
      final db = await database;
      var query = await db.query('note', where: 'id = ?',whereArgs: [id]);
      return query.isNotEmpty ? Note.fromJson(query.first):null;
  }

  getSingleTodo(int id) async{
    final db = await database;
    var query = await db.query('todo', where: 'id = ?',whereArgs: [id]);
    return query.isNotEmpty ? Todo.fromJson(query.first):null;
  }

  updateNote(Note note) async {

    final db  = await database;
    var query = await db.update('note', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
    return query;
  }

  updateTodo(Todo todo) async {

    final db  = await database;
    var query = await db.update('todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
    return query;
  }

  deleteNote(int id) async {
    final db = await database;
    db.delete('note', where: 'id = ?', whereArgs:[id]);
  }

  deleteTodo(int id) async {
    final db = await database;
    db.delete('todo', where: 'id = ?', whereArgs:[id]);
  }


}
