// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, override_on_non_overriding_member, unnecessary_this, avoid_print, use_build_context_synchronously, avoid_unnecessary_containers, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:core';

import 'package:note_application/cred/edit.dart';
import 'package:note_application/cred/viewnotes.dart';
import 'package:note_application/main.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

  bool icon = true;



class _HomePageScreenState extends State<HomePageScreen> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  getUser(){
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }
 
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      
      //backgroundColor: Color.fromARGB(255, 232, 229, 229),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: () async {
           setState(() {
            setState(() {
              icon = !icon;
            });
             if(Get.isDarkMode){
       
            Get.changeTheme(ThemeData.light());
           }else{
            Get.changeTheme(Themes.customDark);
          
            
           }
           });
          },
          icon: Icon( icon ? Icons.nights_stay : Icons.wb_sunny,
          // color: Colors.white,size: 30,
          ),
           ),
          
          IconButton(
          onPressed: ()async{
           await FirebaseAuth.instance.signOut();
           Navigator.of(context).pushReplacementNamed("login") ;
          },
          icon: Icon(Icons.exit_to_app ,// color: Colors.white,size: 30,
          ),
           ),
        ],
        //centerTitle: true,
        title: Text("Notes",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: FutureBuilder(
        
       future:notesref.where("userid",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get(),
      builder: (context , AsyncSnapshot  snapshot){
        if (snapshot.hasData){
          return ListView.builder(
            itemCount:  snapshot.data.docs.length,
            itemBuilder: (context , i){
              return Dismissible(
                onDismissed: ((direction) async {
              await notesref.doc(snapshot.data.docs[i].id).delete();
              await FirebaseStorage.instance.refFromURL(snapshot.data.docs[i]['imageurl']).delete().then((value) => {});
                }),
                 key: UniqueKey(),
                child: ListNotes(notes: snapshot.data.docs[i], docid: snapshot.data.docs[i].id,));
            },
          );
        }
        return Container(
        //  color: Colors.blue,
          child: Center(
            child: CircularProgressIndicator(
              color:Colors.white
            ),
          ));
      },



      ) ,
      
    );
  }
}

class ListNotes extends StatelessWidget {
 late var notes;
 final docid;
 ListNotes ({this.notes , this.docid});
 @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
     Navigator.of(context).push(
      MaterialPageRoute(builder: ((context) {
        return ViewNote(notes: notes,);
      }) )
     );   
      },
      child: Card(
       // color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network("${notes['imageurl']}" ,fit: BoxFit.fill, height: 115,),),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${notes['title']}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                   // color: Colors.black
                  ),
                  ),
                ),
                subtitle: Text("${notes ['note'] }",
                 maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                 // color: Colors.black
                ),
                ),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return EditNote(docid: docid, list: notes,);
                      })
                    );
                  },
                  icon: Icon(Icons.edit , size: 30, //color: Colors.black,
                  ),
                 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
