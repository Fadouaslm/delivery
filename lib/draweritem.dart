import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Drawer_item extends StatelessWidget {
  const Drawer_item({Key? key, required this.name,  required this.icon, required this.onPressed}) : super(key: key);
  final String name ;
  final IconData icon ;
  final Function () onPressed ;
  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height:40.h,
        child: Row(
          children: [
            Icon( icon , color: Colors.black,
              size: 23.sp,) ,
            SizedBox( width:15.w) ,
            Text( name ,  style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: WidthSize*(14.sp/392.72).w ,
              fontWeight: FontWeight.bold,
              color: Colors.black ,
            ),)
          ],
        ),
      ),
    );
  }
}