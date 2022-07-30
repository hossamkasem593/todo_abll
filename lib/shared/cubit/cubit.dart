

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_aball/modules/archive_tasks.dart';
import 'package:todo_aball/modules/done_tasks.dart';
import 'package:todo_aball/modules/new_tasks.dart';
import 'package:todo_aball/shared/cubit/states.dart';

import '../../models/user_model.dart';

class AppCubit extends Cubit <AppStates>
{
 AppCubit() :super(AppInitialState());
    
 AppCubit get(context) => BlocProvider.of(context);

 int currentIndex = 0;
 late Database database;
 
 List<Map> newTasks = [];
 List<Map> doneTasks = [];
 List<Map> archiveTasks = [];

List<UserModel> users = [
    UserModel(id: 10, name: '222', Phone: 010),
  ];

  
  List<Widget> screens = [
    NewTsaksScreen(),
    DoneTsaksScreen(),
    ArchiveTsaksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'ArchiveTasks',
  ];

  void changeIndex (int index )
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  
  void CreateDataBase()  {
     openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database create');
        await database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT ,status TEXT)')
            .then((value) {
          print('Table Create');
        }).catchError((onError) {
          print('error create ${onError.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database open');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }
 inserttToDataBase(
      {@required String? title,
      @required String? time,
      @required String? date}) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title,  date,time, status) VALUES("$title", "$date", "$time"."new")')
          .then((value) {
        print('$value insert sucessfully');
        emit(AppInserttToDataBaseBarState());
               getDataFromDatabase(database);
      }).catchError((onError) {
        print('error insert ${onError.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database)  {
    newTasks =[];
    doneTasks = [];
    archiveTasks = [];
    emit( AppGetDataBaseLoadingState());
     database.rawQuery('SELECT * FROM Tasks').then((value) {
      
              if(['status']== 'new ')
              {
               newTasks.add(value);
              }
           
           else if(['status'] == 'done ')
            {
               doneTasks.add(value);
            }else 
            {
               archiveTasks.add(value);
            }
        
        
       });
  }
  bool isBottomSheetShow = false;
  IconData fadIcon = Icons.edit;

  void ChangeBottomSheetState({@required bool? isShow,@required IconData? icon})
  {

    isBottomSheetShow = isShow!;
    fadIcon = icon!;
    emit(AppChangeBottomSheetState());
  }
  void UpdataDate({@required String? status,@required int? id}) async
  {
     database.rawUpdate(
    'UPDATE Tasks SET status = ?, WHERE id = ?',
    ['${status}',id]).then((value){
      getDataFromDatabase(database);
      emit(AppUpDataBaseState());

    });
      
  }
  void deleteDate({@required int? id}) async
  {
     database.rawDelete(
    'DELETE FROM Tasks WHERE id = ?', [id]).then((value){
      getDataFromDatabase(database);
      emit( AppDeleteDataBaseState());

    });
      
  }
}