import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/auth/user.dart';
import 'package:untitled1/recuperation.dart';
import 'auth/auth.dart';


class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  bool _secureText = true;
  String _id = '', _password = '',erreur='';
  FirebaseAuth usertab = FirebaseAuth.instance;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Se connecter.png"),
                fit: BoxFit.cover),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.w, 100.h, 38.w, 50.h),
                        child: Container(
                          height: 80.h,
                          width: 283.w,
                          child: Center(
                            child: Text('Se connecter',
                                textScaleFactor: 0.96.sp,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 40.sp,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                      Container(
                        //container card
                        width: 300.w,
                        height: 288.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.1.w,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5.r,
                                blurRadius: 7.r,
                                offset: Offset(5, 5),
                              ),
                            ]),
                        child: Column(
                          //column de contenu de container
                          children: [
                            SizedBox(
                              //le premier espace
                              height: 15.h,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14.h,
                                                horizontal: 0.w),
                                            child: Container(
                                              width: 260.w,
                                              height: 40.h,
                                              color: Colors.transparent,
                                              child: TextFormField(
                                                //lgris lewel
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0.h),
                                                  counterText: "",
                                                  border: InputBorder.none,
                                                  hintText: 'Email',
                                                  hintStyle: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey[500],
                                                  ),
                                                  fillColor: Color(0xffF6F6F6),
                                                  filled: true,
                                                ),
                                                /*maxLength: 5,
                                                keyboardType:
                                                TextInputType.number,*/
                                                textInputAction:
                                                    TextInputAction.next,
                                                onChanged: (value) {
                                                  setState(() {
                                                    this._id = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            //troisieme espace
                                            height: 15.h,
                                          ),
                                          Container(
                                            //lgris deuxieme
                                            width: 260.w,
                                            height: 40.h,
                                            color: Colors.transparent,
                                            child: TextFormField(
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0.h),
                                                border: InputBorder.none,
                                                hintText: 'Mot de passe',
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                      _secureText
                                                          ? Icons.remove_red_eye
                                                          : Icons
                                                              .visibility_off,
                                                      color: Colors.grey[500]),
                                                  iconSize: 20.sp,
                                                  onPressed: () {
                                                    setState(() {
                                                      _secureText =
                                                          !_secureText;
                                                    });
                                                  },
                                                ),
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.grey[500],
                                                  fontSize: 15.sp,
                                                ),
                                                fillColor: Color(0xffF6F6F6),
                                                filled: true,
                                                isCollapsed: true,
                                              ),
                                              obscureText: _secureText,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onChanged: (value) {
                                                setState(() {
                                                  this._password = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            //troisieme espace
                                            height: 3.h,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Recuperation()));
                                            },
                                            child: Text(
                                              'Mot de passe oublié?',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Container(
                                      //
                                      color: Colors.transparent,
                                      child: SizedBox(
                                        width: 195.w,
                                        height: 42.h,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                      MyUser? result = await _auth.signeInWithEmailAndPassword(this._id, this._password);
                                      if (result ==null){
                                        erreur = 'you could not signe in with this ';
                                            };
                                          },
                                          child: Text('Se connecter',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              )),
                                          style: ElevatedButton.styleFrom(
                                            shadowColor: Colors.grey,
                                            primary: Color(0xffb80000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      //cienquiéme espace
                                      height: 15.h,
                                    ),
                                    Text (
                                      erreur,
                                      style: TextStyle(color: Colors.red,fontSize: 12.sp,),
                                    )
                                  ],
                                )), //container lbyadh
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
