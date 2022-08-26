// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

showLoading(context){
  return showDialog(
    context: context,
     builder: (context){
      return AlertDialog(
        //backgroundColor: Colors.white,
        title: Text("Please Wait", 
        style: TextStyle(
         // color: Colors.blue
        ),
        ),
        content: Container(
          height: 50,
          child: Center(child: CircularProgressIndicator(//color: Colors.blue,
          ))),
      );
     },
     
     );
}