// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application/auth/lognin.dart';
import 'package:note_application/auth/sign.dart';
import 'package:note_application/cred/add.dart';
import 'package:note_application/cred/edit.dart';
import 'package:note_application/home/homepage.dart';
import 'package:note_application/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool? islogin;

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
 var user = FirebaseAuth.instance.currentUser;
 if(user == null){
  islogin = false;
 }else{
  islogin = true;
 }
  runApp( 
    
   GetMaterialApp(
    theme: Themes.customDark,
     debugShowCheckedModeBanner: false,
     home: islogin == false? LoginScreen(): HomePageScreen(),
     routes: {
      "sign":(context) => SignScreen(),
      "login":(context) => LoginScreen(),
      "home" :(context) => HomePageScreen(),
      "add" :(context) => AddNote(),
      "test" :(context) => Test(),
      
     },
    ),

  );
}



class Themes {
  static ThemeData customDark = ThemeData.dark().copyWith(
   appBarTheme: AppBarTheme(
    
    actionsIconTheme: IconThemeData(
      color: Colors.cyanAccent
    ),
    titleTextStyle: TextStyle(
      color: Colors.cyanAccent
    )
   ) ,
  iconTheme: IconThemeData(
    color: Colors.cyanAccent
  ),
  buttonTheme: ButtonThemeData(
   buttonColor: Colors.cyanAccent,
   highlightColor: Colors.cyanAccent
  ),
    
  textTheme: TextTheme(
   button: TextStyle(
     color: Colors.cyanAccent
   ),
   caption: TextStyle(
     color: Colors.cyanAccent
   )
  )

  );
}