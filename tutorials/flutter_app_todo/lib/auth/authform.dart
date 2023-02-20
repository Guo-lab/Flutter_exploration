// ignore_for_file: unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; //@ https://pub.dev/packages/google_fonts



class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}


class _AuthFormState extends State<AuthForm> {
  // ----------------------------------
  final _formkey   = GlobalKey<FormState>();
  var _username    = '';
  var _email       = '';
  var _password    = '';
  bool isLoginPage = false;
  // ----------------------------------


  // +++++++++++++++++ Login Register Function ++++++++++++++++++++++
  // After Widget architecture built, async with users
  // ignore: non_constant_identifier_names
  Auth_interact_db () {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      // Sign in or Register both submit the data in the form and Auth State will change
      submitForm(_email, _password, _username);
    }
  }
  submitForm (String email, String password, String username) async { //@ Utilize Firebase https://pub.dev/packages?q=
    //await Firebase.initializeApp();
    
    final auth = FirebaseAuth.instance;                               // https://firebase.google.com/docs/firestore/quickstart
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        // User Register
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid = authResult.user!.uid;

        // AppUser appUser = AppUser(uid: authResult.user!.uid, name: authResult.user!.displayName);

        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          "username": username,
          "email":    email,
        });
      }
    } catch (err) { 
      // ignore: avoid_print
      print('submitForm() partially handled ${err.runtimeType}. :( ');
      rethrow; 
    }
  }
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ After this, goto main to design router to HomePage


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Not like Container, SizedBox can be const and won't create a new instance during runtime
      height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,

      child: ListView(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),

            child: Form(
              key: _formkey, //@ GlobalKey<FormState>()
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //+-----------------------------------------------------------
                  if (!isLoginPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'), // key should be unique

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Name (*_*;)';
                        }
                        return null;
                      },
                      onSaved:(newValue) {
                        _username = newValue!;
                      },

                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide()
                          ),
                          labelText: "Please Enter UserName here :)",
                          labelStyle: GoogleFonts.roboto()
                      ),
                    ),

                  Padding(padding: EdgeInsetsDirectional.only(top: 10)),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),

                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid Email \'_\'';
                      }
                      return null;
                    },
                    onSaved:(newValue) {
                      _email = newValue!;
                    },

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide()
                        ),
                        labelText: "Please Enter Email here :)",
                        labelStyle: GoogleFonts.roboto()
                    ),
                  ),

                  Padding(padding: EdgeInsetsDirectional.only(top: 10)),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid Password ^_^;';
                      }
                      return null;
                    },
                    onSaved:(newValue) {
                      _password = newValue!;
                    },

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide()
                        ),
                        labelText: "Please Enter Password here :)",
                        labelStyle: GoogleFonts.roboto()
                    ),
                  ),

                  //+-----------------------------------------------------------

                  // ----  ----  ----  ---- User Button ----  ----  ----  ----  
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: double.infinity,
                    height: 70, 
                    child: ElevatedButton(
                      onPressed: () { Auth_interact_db(); },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[200], 
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ), 
                      child: isLoginPage? 
                        Text('Login',  style: GoogleFonts.roboto(fontSize: 16),) 
                        : 
                        Text('SignUp', style: GoogleFonts.roboto(fontSize: 16),),
                    )
                  ),

                  Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginPage = !isLoginPage;
                        });
                      }, // Invert the status
                      child: isLoginPage?
                        Text('Not a member yet? ^_^') :
                        Text('Already a member? ^_^'), 
                    ),
                  ),
                  // ----  ----  ----  ----  ----  ----  ----  ----  ----  ----
                  
                ], // children of Column
              ),
            ),),

        ],
      ),);
  } // Widget Build 



} // class _AuthFormState
