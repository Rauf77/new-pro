import 'package:firebase_auth/firebase_auth.dart';

import '../Model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object
  Custom? _user(User users) {
    return users != null ? Custom(uid: users.uid) : null;
  }

  //auth change user stream
  Stream<Custom?> get user {
    return _auth.authStateChanges().map((User? user) => _user(user!));
  }
  //Sign in
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email:email,password:password);
      User user=result.user!;
      return _user(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //register
  Future registerWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email:email,password:password);
      User user=result.user!;


    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _user(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
