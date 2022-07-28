import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_aball/models/user_model.dart';
import 'package:todo_aball/modules/archive_tasks.dart';
import 'package:todo_aball/modules/done_tasks.dart';
import 'package:todo_aball/modules/new_tasks.dart';
import 'package:todo_aball/shared/components/components.dart';
import 'package:todo_aball/shared/components/constants.dart';
import 'package:todo_aball/shared/cubit/cubit.dart';
import 'package:todo_aball/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';

class HomeLayout extends StatelessWidget {
  
 AppCubit cubit =  AppCubit().get('context');
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();
  bool isBottomSheetShow = false;
  IconData fadIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Center(
                child: Text(
                 cubit.titles[cubit.currentIndex],
                  style: TextStyle(fontSize: 25, color: Colors.amber),
                ),
              ),
              backgroundColor: Colors.black12,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (isBottomSheetShow) {
                  if (formdKey.currentState!.validate()) {
                    inserttToDataBase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    ).then((value) {
                      getDataFromDatabase(database).then((value) {
                        Navigator.pop(context);

                        // setState(() {
                        //     isBottomSheetShow = false;
                        //      fadIcon = Icons.edit;

                        //   tasks = value;
                        //   print(tasks);
                        // });
                      });
                    });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          elevation: 20,
                          (context) => Container(
                                padding: EdgeInsets.all(20.0),
                                color: Colors.white,
                                child: Form(
                                  key: formdKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultFormField(
                                        controller: titleController,
                                        type: TextInputType.text,
                                        label: 'Task Title',
                                        prefix: Icons.email,
                                        validation: 'title must not be empty',
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaultFormField(
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        label: ' Task Time ',
                                        prefix: Icons.watch_later_outlined,
                                        validation: 'time must not be empty',
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value?.format(context));
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaultFormField(
                                        controller: dateController,
                                        type: TextInputType.datetime,
                                        label: ' Task Date ',
                                        prefix: Icons.calendar_today,
                                        validation: 'date must not be empty',
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('5/5/2022'),
                                          ).then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                            print(DateFormat.yMMMd()
                                                .format(value!));
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                      .closed
                      .then((value) {
                    isBottomSheetShow = false;
                    // setState(() {
                    //   fadIcon;
                    // });
                  });

                  isBottomSheetShow = true;
                  // setState(() {
                  //   fadIcon = Icons.title;
                  // });
                }

                //   try{
                //  var name =await getName();
                //   print(name);
                //       }catch(error){

                //        print('error ${erorr.toString()}');

                //       }
                //   getName().then((value) {
                //     print(value);
                //    print('osama');
                //    throw('انا عملت ايرور');

                //   }).catchError((onError){
                // print('error ${onError.toString()}');
                //   });
              },
              child: Icon(fadIcon),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) {
                return  cubit.screens[ cubit.currentIndex];
              },
              fallback: (context) {
                return Center(child: CircularProgressIndicator());
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex:  AppCubit().get(context).currentIndex,
                onTap: (index) {
                cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archive',
                  ),
                ]),
          );
        },
      ),
    );
  }

  void CreateDataBase() async {
    database = await openDatabase(
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
        getDataFromDatabase(database).then((value) {
          // setState(() {
          //   tasks = value;
          //   print(tasks);
          // });
        });
        print('database open');
      },
    );
  }

  Future inserttToDataBase(
      {@required String? title,
      @required String? time,
      @required String? date}) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title,  date,time, status) VALUES("$title", "$date", "$time"."new")')
          .then((value) {
        print('$value insert sucessfully');
      }).catchError((onError) {
        print('error insert ${onError.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM Tasks');
  }
}

// Future<String> getName() async {
//   return 'Ali';
// }
