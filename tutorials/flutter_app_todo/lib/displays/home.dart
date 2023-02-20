// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/displays/add_tasks.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  // ---- Get User Uid at the beginning ----
  @override
  void initState() {
    getUid();
    super.initState();
  }
  String uid = '';
  getUid () async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User   user = auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }
  // ---------------------------------------
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        // ^^^^^^^^^^^^^^^ Sign Out ^^^^^^^^^^^^^^^^
        actions: [IconButton(onPressed: () async { await FirebaseAuth.instance.signOut(); }, icon: Icon(Icons.logout))],
      ),


      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        color:  Colors.yellow.shade100,
        

        // --------- I did not edit this Task Display Module much --------------
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('tasks').doc(uid).collection('mytasks').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {//if (snapshot.connectionState == ConnectionState.waiting) {
              print(snapshot);
              return Center( 
                child: CircularProgressIndicator(), 
              ); // Loading Circle, rotating
            } else {
              final docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: docs?.length,
                itemBuilder: (context, index) {
                  // HERE, Return InkWell here with Child Container
                  // OnTap(), Navigator to Description Page
                  return Container( 
                    margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 80,
                    // ------- Container Content --------
                    // ----------------
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Place the Delete Button Aside
                      children: [ 
                        Column( ////mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [ Text(docs?[index]['task'], style: GoogleFonts.newRocker(fontSize: 25),), ],
                          // How to embed Description here, imagine this. HaHa
                        ),
                        Container( child: IconButton(
                            icon: Icon(Icons.delete_forever), 
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                .collection("tasks").doc(uid)
                                .collection("mytasks").doc(docs?[index]['task']) // ['tasks'] or ['times']: still a little bit confused 
                                .delete();
                            },
                        ),),
                      ], // ------------
                    ), // ------------------------------
                  );
                }, // Item Builder
              );
            } // Else Ending, place the tasks on this page (in the ListView)
          }
        ),
        // ---------------------------------------------------------------------
      
      ), // The Whole body ends here


      // ======== To AddTasks Page ========
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddTasks(),
          ));
        },
        backgroundColor: Colors.green[400],
        child: 
          Icon( Icons.add, 
                color: Colors.white,
                size: 40,
          ),
      ),


    );
  }


}
