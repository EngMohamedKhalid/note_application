// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously, depend_on_referenced_packages, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_null_comparison, curly_braces_in_flow_control_structures, avoid_print
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';  
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_application/component/alert.dart';
import 'package:path/path.dart';
class EditNote extends StatefulWidget {
  final docid;
  final list;
  const EditNote({Key? key , this.docid , this.list}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  
  showBottomSheet(context){
    return showModalBottomSheet(context: context, 
    builder: (context) {
      return Container(
        color: Colors.black,
        padding: EdgeInsets.all(20),
        height: 200,
        child: Column(
          children: [
          Text(" Edit The Photo",
          style: TextStyle(
           // color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
               var picked = await ImagePicker().pickImage(source: ImageSource.gallery);    
               if(picked != null){
                file = File(picked.path);
                var rand = Random().nextInt(1000000);
                var imagename = "$rand"+ basename(picked.path);
            ref =    FirebaseStorage.instance.ref("images").child(imagename);
               Navigator.of(context).pop();
               
               }
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.photo_library_outlined, size: 30,
                   // color: Colors.cyan,
                    ),
                    SizedBox(width: 20,),
                   Text("From Gallery",
                 style: TextStyle(
                 // color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
              ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
           Expanded(
             child: InkWell(
              onTap: () async {
                 var picked = await ImagePicker().pickImage(source: ImageSource.camera);    
               if(picked != null){
                file = File(picked.path);
                var rand = Random().nextInt(1000000);
                var  imagename = "$rand"+ basename(picked.path);
                ref = FirebaseStorage.instance.ref("images").child(imagename);
               Navigator.of(context).pop();
               
               }
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.photo_camera, size: 30,
                  //  color: Colors.cyan,
                     ),
                    SizedBox(width: 20,),
                   Text("From Camera",
                 style: TextStyle(
                //  color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
              ),
                  ],
                ),
              ),
                     ),
           ),
        ],
        ),
      );
    },
    
    
    );
  }



 

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  editNote (context)async {
    var formdata = formstate.currentState;
    if (file == null){
       if(formdata!.validate()){
      showLoading(context);
      formdata.save();
       await notesref.doc(widget.docid).update({
        "title": title,
        "note": note,
      }).then((value) => {
       Navigator.of(context).pushNamed("home")
      }).catchError((e){
         print("$e");
      });
     
    }

    } else{
       if(formdata!.validate()){
      showLoading(context);
      formdata.save();
        await ref.putFile(file);
      imageurl = await ref.getDownloadURL();
       await notesref.doc(widget.docid).update({
        "title": title,
        "note": note,
        "imageurl":imageurl,
              }).then((value) => {
       Navigator.of(context).pushNamed("home")
      }).catchError((e){
         print("$e");
      });
     
    }

    }
   
  }
  late Reference  ref ;
 late File file;
 
  var title ;
   var note ;
   var imageurl;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Your Notes",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Form(
        key: formstate,
        child: Column(
          children: [
            SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 15 , right: 15),
                child: TextFormField(
                  initialValue: widget.list['title'],
                 onSaved: (val){
                  title = val;
                 },
                  maxLength: 40,
                  decoration: InputDecoration(
                    filled: true,
                    //fillColor: Colors.white,
                    prefixIcon: Icon(Icons.note , size: 30,),
                    label: Text ("Note Title",
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
                  maxLength: 100000,
                 initialValue: widget.list['note'], 
                  onSaved: (val){
                  note = val;
                 },
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                   // fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.edit_note , size: 30,),
                    label: Text (" Your Note",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(right: 140),
                  child: Text("* Note : You Must Edit the photo , too ",
                       style: TextStyle(
                         color: Colors.cyanAccent,
                          fontSize: 15,
                             fontWeight: FontWeight.bold,
                         ),
                            ),
                ),
             SizedBox(height: 30,),
              MaterialButton(
                color: Colors.cyanAccent,
                onPressed: (){
                 showBottomSheet(context);
                },
                child: Text("Edit Your Photo For The Note " ,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                     // color: Colors.white
                    ),
                    ) ,
                ),
                
              SizedBox(height: 30,),
               MaterialButton(
                
               color: Colors.cyanAccent,
                onPressed: () async{
                 await editNote(context);
 
                },
                child: Text("Save Changes " ,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                     // color: Colors.white
                    ),
                    ) ,
                ),
          ],
        ),
      ),
    );
    
  }
}