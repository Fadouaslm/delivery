
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/database/database.dart';

import 'auth/user.dart';
import 'livreur/historique.dart';
class Historiques extends StatefulWidget {
  const Historiques({Key? key}) : super(key: key);
  @override
  State<Historiques> createState() => _HistoriquesState();
}

class _HistoriquesState extends State<Historiques> {


  @override
  Widget build(BuildContext context) {


    final user = Provider.of<MyUser>(context);

    return StreamBuilder<List<Historique>>(
      stream: DatabaseService(uid: user.uid).livreurhis,
      builder: (context, snapshot) {

        if (snapshot.hasData){

          final List<Historique>? his =snapshot.data;
          if (his != null ){
          return SafeArea(child: Scaffold (
            appBar : AppBar(
              title: Align( child: Text('Historiques' ,style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 18.sp ,
                fontWeight: FontWeight.bold ,
              ),),
                alignment: Alignment.center,),
              backgroundColor:const Color(0xffB80000),
            ),
            body:
            Column(
              children: [
                SizedBox( height: 0.h,) ,

                Container(
                  margin: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0.h),
                  height: MediaQuery.of(context).size.height - (10.h+MediaQuery.of(context).padding.bottom +
                      MediaQuery.of(context).padding.top+AppBar().preferredSize.height) ,
                  width:350.w,
                  color: Colors.transparent,
                  child: ListView.builder(
                    //itemCount:historique.length ,
                      itemCount:his.length ,
                      itemBuilder: (context, i){
                        final hst = his[i].heure;
                        final hsd = his[i].date;
                         int j = i+1;
                        return Column(
                          children: [
                            Container(
                              height:65.h ,
                              width: 350.w ,
                              color: const Color(0xb3C4C4C4),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(left: 10.w , top: 10.h , right:180.w ),
                                          child: Text(
                                            //"$hs" ,
                                            'Commande $j',

                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp ,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:  EdgeInsets.only(  left :0 , right: 10, bottom: 0 , top: 10.h),
                                          child: Text(
                                            "$hsd" ,

                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp ,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 250.w ),
                                    child: Text(
                                      "$hst" ,

                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp ,
                                      ),
                                    ),
                                  ),

                                ],
                              ),


                            ),
                            SizedBox(height: 10.h,),
                          ],
                        );
                      }),
                ),
              ],
            ),
          )
          );}
          else {return SafeArea(child: Scaffold (
            appBar : AppBar(
            title: Align( child: Text('Historiques' ,style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18.sp ,
              fontWeight: FontWeight.bold ,
            ),),
        alignment: Alignment.center,),
        backgroundColor:const Color(0xffB80000),
        ),
        body: Container()));}
        }else{
          return Container();
        }

      }
    ) ;
  }
}
