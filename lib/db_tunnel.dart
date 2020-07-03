import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mnoteapp/db_files.dart';
//import 'package:mnoteapp/model.dart';
//import 'package:mnoteapp/repository_service.dart';

class Backend{

String myWord = "";
int mid;
int frquency;
String mwrd;
  //Future <List<Note>> future = RepositoryService.getAllNotes();

  var controller= TextEditingController();
  TextEditingController controller1= TextEditingController();
  final  _streamController = StreamController<String>();
  StreamSink<String> get save => _streamController.sink;
  Stream  get stream => _streamController.stream;

  final _newcounter = StreamController<Word>();
  Sink<Word> get newC => _newcounter.sink;






  checkTextfields(){
    (controller.text =="" || controller1.text == "") ?print('no'):

    print(controller1.text+controller.text);
    _save();
  }

check(){
    _readAll();
    _read();
    //getCount();
}

String get body{
    //return myWord;
}


  _save() async {
    Word word = Word();
    word.word = 'hello';
    word.frequency = 15;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');
  }

    _readAll() async{
      DatabaseHelper helper = DatabaseHelper.instance;
      Word word = await helper.queryAll();
      if(word == null){
        print("row empty");
      }else{
        print('${word.id},${word.word},${word.frequency}');

        //sink.add(word.word);
      }
}
   _read() async {
     DatabaseHelper helper = DatabaseHelper.instance;
     int rowId = 1;
     Word word = await helper.queryWord(rowId);

     if (word == null) {
       print('read row $rowId: empty');
     } else {
       output(rowId, word.frequency, word.word);
       print('read row $rowId: ${word.word} ${word.frequency}, $myWord');
        //sink.add(rowId);
       //sink.add(rowId);
       //sink.add(word.word);
       //body(word.word);
       //body.add(word.word);
       //myWord = word.word;
       return word.word;
     }
   }

getCount() async{
      DatabaseHelper helper = DatabaseHelper.instance;
      helper.getCount();
      //sink.add(getCount());
  }

void disData(Word word){
  if(word==null)
    //save.add();
  myWord="Empty";
  else
    myWord="yes";
    save.add(myWord.toString());
}

output(int id, int freq, String wrd){
  mid = id;
  frquency = freq;
  mwrd  = wrd;
}

  dispose(){
    _streamController.close();
  }
}

