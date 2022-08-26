
import 'package:flutter/material.dart';



class Test extends StatefulWidget {
   Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
    bool isVisable = true;

// DocumentReference doc = FirebaseFirestore.instance.collection("users").doc("Ut1zZA3h6jBbEHXOX18x");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
           Visibility(
             visible: isVisable,
            child: Container(
              color: Colors.amber,
              height:600,
              width: 600,
      child: Image.network("https://wallpapercave.com/wp/wp2549583.jpg",fit: BoxFit.fill,),
      ),
      replacement: Container(
        height: 600,
        width: 600,
      ),
       ),
            CheckboxListTile(
              activeColor: const Color.fromARGB(255, 141, 5, 165),
              checkColor: Colors.black,
              title: const Text("Show Photo ",
               style: TextStyle(
                fontSize: 20,
                color: Colors.purple
              ),
              ),
              value: isVisable, onChanged: ((value) {
              setState(() {
                isVisable =value! ;
              });
            })
            ),
            CheckboxListTile(
              activeColor: const Color.fromARGB(255, 156, 9, 182),
              checkColor: Colors.black,
              title: const Text("Hide Photo ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.purple
              ),
              ),
              value:!isVisable, onChanged: ((value) {
              setState(() {
                isVisable =!value! ;
              });
            })
            ),
        ],
      )),
    );
  }
}



// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace


