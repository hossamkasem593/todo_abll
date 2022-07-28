// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, implementation_imports

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:todo_aball/shared/components/components.dart';
import 'package:todo_aball/shared/components/constants.dart';

class NewTsaksScreen extends StatelessWidget {
  const NewTsaksScreen({
    Key? key,
     
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return   buildTaskItem(tasks[index]);
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
      itemCount: tasks!.length,
      );
      
  }
}
