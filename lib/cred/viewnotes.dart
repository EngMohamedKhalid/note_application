// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final notes ;
  const ViewNote({Key? key , this.notes}) : super(key: key);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Note Details ",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Image.network("${widget.notes['imageurl']}",
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
                )
                ),
                Container(
                  margin:  EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Note Title :",
                        softWrap: true,
                        textScaleFactor: 1.25,
                        style: TextStyle(
                          fontSize: 20,
                         // color: Colors.red,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                      Text(" ${widget.notes['title']}" , 
                      softWrap: true,
                        textScaleFactor: 1.25,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:  EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Note Content :",
                        softWrap: true,
                        textScaleFactor: 1.25,
                    style: TextStyle(
                        fontSize: 20,
                      //  color: Colors.red,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("${widget.notes['note']}" , 
                        softWrap: true,
                        textScaleFactor: 1.25,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}