
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'accuil.dart';
import 'auth/user.dart';
import 'database/database.dart';
class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);


  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    var dt = DateTime.now();
    String date=dt.year.toString()+"/"+dt.month.toString()+"/"+dt.day.toString();
    String str =dt.year.toString()+dt.month.toString()+dt.day.toString();
    String time;
    if (dt.hour<10 && dt.minute<10)
    { time = "0"+dt.hour.toString()+":0"+dt.minute.toString();}else
    if (dt.hour<10){
      time = "0"+dt.hour.toString()+"0"+dt.minute.toString();
    }else
      if (dt.minute<10){ time = dt.hour.toString()+":0"+dt.minute.toString();}else
      { time = dt.hour.toString()+":"+dt.minute.toString();};



    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffb80000),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 160.h,
                  width: 120.w,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/haut.png')),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height:20.h ,
            ),
            SizedBox(
              height: 160.h,
              width: 300.w,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'images/moto.png')),
                ),
              ),
            ),

            SizedBox(
              height: 40.h,
            ),
            Container(
              //
              color: Colors.transparent,
              child: SizedBox(
                width: 195.w,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () async {
                    String h=(str+time).toString();

                    DatabaseService(uid:user.uid).updateHestorique(date,time);
                    DatabaseService(uid:user.uid).updateArchive( user.uid, time, date,h);
                    await DatabaseService(uid:user.uid).deletecommande();
                   await  DatabaseService(uid:user.uid).setupexist();
                    Navigator.push(
                        context, MaterialPageRoute(
                      builder: (context) =>Acceuil(etape: 'Accune commande'  ,  ),));
                  },
                  child: Text('C\'est parti',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        color: Colors.black,
                      )),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.grey,
                    primary: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              //
              color: Colors.transparent,
              child: SizedBox(
                width: 195.w,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},//envoyer le signal a l'administration
                  child: Text('Problème !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        color:const Color(0xffb80000),
                      )),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.grey,
                    primary: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height:100.h,
            ),
            SizedBox(
              height: 160.h,
              //width: 320.w,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'images/bas.png')),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}