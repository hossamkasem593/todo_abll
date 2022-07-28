// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, implementation_imports

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';

class DoneTsaksScreen extends StatelessWidget {
  const DoneTsaksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer(
      listener: (context, state) {
        
      },
      builder:(context , state) {
        var tasks = AppCubit().get(context).doneTasks;
        return tasksBuilder(tasks: tasks);
      }
    );


      
  }
}