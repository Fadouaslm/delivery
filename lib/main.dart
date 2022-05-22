import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/auth/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/auth/auth.dart';
import 'package:untitled1/splash.dart';

import 'accuil.dart';
import 'firstcommand.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value:AuthService().user,
      initialData: null,
      catchError: (e,i) => null,
      child: ScreenUtilInit(
        designSize: const Size(360, 800), //154.3,244.5
        minTextAdapt: true,
        splitScreenMode: true,

        builder:(BuildContext)  =>
             MaterialApp(
              debugShowCheckedModeBanner: false, // no more debug
              home: SplachScreen(),

            ),
      ),
    );
  }
}