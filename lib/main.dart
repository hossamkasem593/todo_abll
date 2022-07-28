// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_aball/layout/home_layout.dart';
import 'package:todo_aball/shared/bloc_observer.dart';

void main() {
 BlocOverrides.runZoned(
    () {
      
    },
    blocObserver: MyBlocObserver(),
  );
  runApp( ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomeLayout(),
     



    );
  }
}