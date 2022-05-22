import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/auth/userdata.dart';
import 'package:untitled1/database/database.dart';

import 'auth/auth.dart';
import 'auth/user.dart';
import 'draweritem.dart';
import 'historique.dart';
import 'infoPer.dart';


class profile extends StatelessWidget {
  String full_name ="";
  String phone_number ="                ";
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<Userdata?>(
        stream: DatabaseService(uid:user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            Userdata? userd=snapshot.data;
            full_name=userd!.name;
            phone_number=userd.phone;
          }
          return Drawer(
            child: Column(
              children: [
                drawerheader ( context) ,
                SizedBox(height:40.h,),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Column(
                      children :[
                        Drawer_item(
                          icon: MdiIcons.account,
                          name: 'Informations Personnelles',
                          onPressed: () { Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> InfoPerso() )
                          ); },) ,
                        SizedBox(height:20.h ,),
                        Drawer_item(
                          icon: MdiIcons.history,
                          name: 'Historiques',
                          onPressed: () { Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> Historiques() )
                          ); },) ,
                        SizedBox(height:20.h ,),
                        Drawer_item(
                          icon: MdiIcons.logout,
                          name: 'Se déconnecter',
                          onPressed: () async{
                            Scaffold.of(context).dispose();
                            await _auth.singeOut();

                          },) ,
                      ] ),
                )],
            ),
          );
        }
    );
  }
  Widget drawerheader (BuildContext context){
    double WidthSize = MediaQuery.of(context).size.width;
    final user = Provider.of<MyUser?>(context);

    return Material(
      color: Color(0xffB80000),

      child: SizedBox(
        height: 180.h ,
        child :Row(

          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:30.h) ,

                  Padding(
                    padding:  EdgeInsets.only(right: 190.w),
                    child: CircleAvatar(
                        radius: 40.sp,
                        backgroundImage:
                        NetworkImage(DatabaseService(uid:user!.uid).image())

                    ),
                  ),
                  SizedBox(height:20.h),
                  Text( full_name,

                    style: TextStyle(
                      //fontFamily: 'Poppins',
                      fontSize:  WidthSize*(18.sp/392.72) ,
                      //  fontWeight: FontWeight.bold,
                      color: Colors.white ,
                    ),),
                  Text( '+213  ' + phone_number.substring(1,2)+' '+phone_number.substring(2),
                    style: TextStyle(
                      //fontFamily: 'Poppins',
                      fontSize: WidthSize*(12.sp/392.72) ,
                      color: Colors.red[200],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}