import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/Services/auth.dart';
import 'package:fire/Shared/constant.dart';
import 'package:fire/Shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign_In extends StatefulWidget {
  final Function view;
  Sign_In({required this.view});
  //const Sign_In({Key? key, required this.view}) : super(key: key);

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  String uId = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown[400],
        title: Text('Log In Brew Crew'),
        centerTitle: true,
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.view();
              },
              icon: Icon(Icons.login),
              label: Text('Register'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),

                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Password'),

                    validator: (val) =>
                    val!.length < 6
                        ? 'Enter a password 6+ characters long'
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Not Registerd ';
                            loading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.brown,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () async {
                      signWithGoogle();
                    },
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          'https://image3.mouthshut.com/images/imagesp/925000521s.png'),
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  )
                ],
              ))),
    );
  }

  Future<void> signWithGoogle() async {
    GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignIn!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    uId = userCredential.user!.uid;
    var userid = userCredential.user?.uid;
    var username = userCredential.user?.displayName;
    var userimage = userCredential.user?.photoURL;
    var useremail = userCredential.user?.email;
    FirebaseFirestore.instance.collection('user').doc(userid).set({
      'userid': userid,
      'username': username,
      'useremail': useremail,
      'userimage': userimage,
    });
  }
}
