import 'package:flutter/material.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/todo_ui.dart';

import 'database/blocs/todos_bloc.dart';

class MainTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        bloc: TodosBloc(),
        child: Scaffold(
          backgroundColor: Colors.black45,
          body: TodoUi(),
        ),
      ),
    );
  }
}
