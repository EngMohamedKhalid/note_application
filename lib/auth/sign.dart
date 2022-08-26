// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, use_build_context_synchronously, avoid_single_cascade_in_expression_statements
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_application/component/alert.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool isPassword = true;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
   
  var Myusername ,Myemail , Mypassword;
  late UserCredential userCredential;
  Future signUp () async {
    var formdata = formstate.currentState;
    if (formdata!.validate()){
     formdata.save();
     try {
      showLoading(context);
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: Myemail,
    password: Mypassword,
  );
  print(userCredential);
   return userCredential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    Navigator.of(context).pop();
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            title: 'Hint',
            desc: 'Your Password is too small',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            )..show();
   
  } else if (e.code == 'email-already-in-use') {
     Navigator.of(context).pop();
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            title: 'Hint',
            desc: 'Your email is aleardy used',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formstate,
            child: Column(
              children: [
                SizedBox(height: 70,),
                Image.asset("images/1.jpg" ,width: 200,height: 200,),
                SizedBox(height: 15,),
                Text("Sign_Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  //color: Colors.black
                ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 15),
                  child: TextFormField(
                    onSaved: (val) {
                      Myusername = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person , size: 30,),
                      label: Text ("User_Name",
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
                    onSaved: (val){
                      Myemail = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email , size: 30,),
                      label: Text ("Email",
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
                      Text("If You Have An Account " ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      //  color: Colors.black
                      ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed("test");
                        },
                       child: Text("Log_In " ,
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
                 SizedBox(height: 30,),
                 MaterialButton(
                 // color: Colors.blue,
                  onPressed: ()async{
                  UserCredential? response =await signUp();
                 if(response != null){
                  await FirebaseFirestore.instance.collection("users").add({
                    "user name":Myusername,
                    "email":Myemail
                  });
                   Navigator.of(context).pushReplacementNamed("home");
                 }else{
                
                 }
                  },
                  child: Text("Sign_Up " ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        //color: Colors.white
                      ),
                      ) ,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}