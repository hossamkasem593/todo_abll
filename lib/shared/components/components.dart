// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 10.0,
  @required String? text,
  bool isUpper = true,
  Color back = Colors.blue,
  @required VoidCallback? function,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: MaterialButton(
        onPressed: function!,
        child: Text(
          isUpper ? text!.toUpperCase():text!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  @required controller,
  hint = '',
  @required type,
 @required final String? validation,
  isPassword = false,
  @required String? label,
  @required IconData? prefix,
  VoidCallback? onTap,
  IconData? subfix,
  bool isClickable = true,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onTap: onTap,
        enabled:isClickable,
        validator:(value) {
        if(value!.isEmpty) {
          return validation;
        }

        return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix) ,
          suffixIcon:subfix !=null? Icon(subfix): null,
          hintText: hint,
          border: InputBorder.none,
          
          
          
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);


Widget buildSeparator() => Container(
  height: 1.0,
  width: double.infinity,
  color: Colors.grey[300],
);

Widget buildTaskItem(Map model){
return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
       children: [
        CircleAvatar(
         radius: 40.0,
      child:Text('${model['time']}'),
            ),
      SizedBox(width: 20.0,),
      Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Text('${model['title']}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
        Text('${model['date']} ',style: TextStyle(color: Colors.grey),),
       ],

      ),
       ],
         
      ),
    );

}