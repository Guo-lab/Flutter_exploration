// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
////import 'dart:developer' as developer;



class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}



class _AddTasksState extends State<AddTasks> {
  // Controller in Text Field, bonding with function related to Firebase
  TextEditingController tasksCtrl   = TextEditingController();
  TextEditingController descripCtrl = TextEditingController();

  addTask2db () async {

    FirebaseAuth auth = FirebaseAuth.instance;
    //final User user = auth.currentUser!; //@ https://github.com/techwithtim/Flutter-Tutorial/issues/1 and migration "https://firebase.flutter.dev/docs/migration/"
    User? user  = auth.currentUser;
    String? uid = user?.uid;
    var  time  = DateTime.now().toString();
    ////print(user);
    print(tasksCtrl.text + descripCtrl.text + time);
    
    // submit to Firebase 
    CollectionReference task = FirebaseFirestore.instance.collection('tasks');
    var data = {
      "task":        tasksCtrl.text,
      "description": descripCtrl.text,
      "time":        time,
      "timestamp":   DateTime.now(),
    };
    task.doc(uid).collection('mytasks').doc(tasksCtrl.text).set(data, SetOptions(merge: true),).then((value) => print("Task Added"))
      .catchError((error) => print("Failed to add a Task: $error"));

    // ! ? ? ? ? ? ? ? ? ? ?  Bug ? ? ? ? ? ? ? ? ? ? ? ?
    // ! it doesnot display on Cloud Firebase Dashboard ! 
    // FirebaseFirestore.instance.collection("tasks").doc(uid).set({
    //     "task":        tasksCtrl.text,
    //     "description": descripCtrl.text,
    //     "time":        time.toString(),
    //   }, SetOptions(merge: true)).onError((e, _) => print("Error writing document: $e"));
    //
    // !
    print('in addTask2db function');
    ////developer.log('log me 1', name: 'Task added.'); //@ https://docs.flutter.dev/testing/code-debugging#logging
    // msg prompt
    Fluttertoast.showToast(msg: 'Task has been added! :)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a new Task")),

      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [

            // --------- Input Field ----------- -----------------
            Container(
              child: TextField(
                controller: tasksCtrl,   // Controller
                decoration: InputDecoration(
                  labelText: "Define a Task, lol",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // --  --  --  --  --  --  --  --  -
            Padding(padding: EdgeInsetsDirectional.only(top: 10)),
            Container(
              child: TextField(
                controller: descripCtrl, // Controllor
                decoration: InputDecoration(
                  labelText: "Enter Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // --------------------------------- -----------------
            


            // ++++++++ Button ++++++++
            // ++++++++++++++++++++++++
            Padding(padding: EdgeInsetsDirectional.only(top: 20)),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  addTask2db(); 
                },

                style: ButtonStyle(
                  // Clicking the button should redirect back to the HomePage and add the task
                  // Use "MaterialStateProperty" to change Button components with different states(e.g. Web hover)
                  //@ "https://www.saoniuhuo.com/question/detail-2490172.html" and "https://api.flutter.dev/flutter/material/MaterialStateProperty-class.html"
                  backgroundColor: MaterialStateProperty.resolveWith(
                    <Color> (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.purple.shade100;
                      }
                      return Theme.of(context).primaryColor;
                  }),
                  elevation: MaterialStateProperty.resolveWith<double?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return 50;
                      }
                      return 5;
                  }), //Version-Update future: any improvements involve size change and text change?
                ),
                
                child: Text('A D D    O N E', style: GoogleFonts.lobster(fontSize: 30),), //@ https://fonts.google.com/
              ),
            ),
            // ++++++++++++++++++++++++
            // ++++++++++++++++++++++

          ],
        ),
      ),
    );

  }

}