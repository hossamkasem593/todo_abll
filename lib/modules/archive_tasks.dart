// ignore_for_file: unnecessary_import, duplicate_ignore, avoid_unnecessary_containers, implementation_imports

// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';

class ArchiveTsaksScreen extends StatelessWidget {
  const ArchiveTsaksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer(
      listener: (context, state) {
        
      },
      builder:(context , state) {
        var tasks = AppCubit().get(context).archiveTasks;
        return ListView.separated(
        
        itemBuilder: ((context, index) {
          
          return   buildTaskItem(tasks[index],context);
        }
        ), 
        separatorBuilder:(context,index){
          return      
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: Container(
              width:double.infinity,
              height: 1.0,
              color:Colors.grey ,
            ),
          );
        } , 
       itemCount: tasks.length,
      );
      }
    );
  }
}