// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_single_cascade_in_expression_statements, avoid_print, unused_local_variable, use_build_context_synchronously, sized_box_for_whitespace

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_application/component/alert.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
   late UserCredential userCredential;
   Future LogIn () async {
    var formdata = formstate.currentState;
    if (formdata!.validate()){
     formdata.save();
     try {
      showLoading(context);
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: Myemail,
    password: Mypassword,
  );
  print(userCredential);
   return userCredential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    Navigator.of(context).pop();
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.LEFTSLIDE,
            title: 'Hint',
            desc: 'No user found for that email',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            )..show();
   
  } else if (e.code == 'wrong-password') {
    Navigator.of(context).pop();
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            title: 'Hint',
            desc: 'Wrong password provided for that user.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            )..show();
  }
} catch (e) {
  print(e);
}
    
    } else {


    }
  }
  var Myemail , Mypassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formstate,
          child: Column(
            children: [
              SizedBox(height: 70,),
                Image.asset("images/1.jpg" ,width: 200,height: 200,),
                SizedBox(height: 15,),
                Text("Log_In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                 // color: Colors.black
                ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 15),
                  child: TextFormField(
                    onSaved: (val){
                      Myemail = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email , size: 30,),
                      label: Text ("E_mail",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                           Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 15),
                  child: TextFormField(
                     onSaved: (val) {
                      Mypassword = val;
                    },
                    // 
                    obscureText: isPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password , size: 30,),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                       icon: Icon(isPassword ? Icons.visibility_off : Icons.visibility),
                       ),
                      label: Text ("Password",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You Have Not An Account ?  " ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                       // color: Colors.black
                      ),
                      ),
                      TextButton(
                        onPressed: () {
                       Navigator.of(context).pushReplacementNamed("sign");
                        },
                       child: Text("Sign_Up " ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                       // color: Colors.red
                      ),
                      ),
                       
                       ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
               MaterialButton(
                  color: Colors.blue,
                  onPressed: ()async{
                    UserCredential? user = await LogIn();
                     if(user != null){
                      Navigator.of(context).pushReplacementNamed("home");
                   }else{
                
                 }
                  
                  },
                  child: Text("Log_In " ,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                      ) ,
                  ),
               
            ],
          ),
        ),
      ),
    );
  }
}