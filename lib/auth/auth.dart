import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/auth/user.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference livreurCollection = FirebaseFirestore.instance.collection('livreur');
  // convert FirebaseUser to MyUser
  MyUser? _useFromFireBaseUser(User? user){
    if (user != null) {
      return MyUser(uid: user.uid,email: user.email );
    } else {
      return null;
    }
  }
  // auth change user stream
Stream<MyUser?> get user{
    return _auth.authStateChanges().map((user) => _useFromFireBaseUser(user));

}
// signe out
Future singeOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      return null ;
    }
}
// signe in with email and password

Future signeInWithEmailAndPassword(String email , String password) async{
    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      User? user = result.user;
      if (user == null) {
        return null ;
      } else {
      return _useFromFireBaseUser(user);}
    }catch(e){

      return null;
    }
}
//reset email
}