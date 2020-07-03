import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnoteapp/database/blocs/bloc_provider.dart';
import 'package:mnoteapp/database/blocs/notes_bloc.dart';

import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
          bloc: NotesBloc(),
          child: Scaffold(
            backgroundColor: Colors.black45,
            body: Home(),

    ),
        ),
        );
  }
}