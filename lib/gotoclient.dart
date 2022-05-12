import 'package:flutter/material.dart';
import 'accuil.dart';
import 'done.dart';
class GoToClient extends StatefulWidget {
  const GoToClient({Key? key}) : super(key: key);

  @override
  State<GoToClient> createState() => _GoToClientState();
}

class _GoToClientState extends State<GoToClient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( child: Scaffold(body :
    Acceuil(etape: 'Aller au client'  , destination: Done(), ),
    ),);
  }
}