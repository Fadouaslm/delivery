
import 'package:flutter/material.dart';
import 'accuil.dart';
import 'commande.dart';
class  Livrer extends StatefulWidget {
  const  Livrer({Key? key}) : super(key: key);

  @override
  State< Livrer> createState() => _LivrerState();
}

class _LivrerState extends State< Livrer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( child: Scaffold(body :
    Acceuil(etape: 'Aller au restaurant'  , destination: const commande(), ),
    ),);
  }
}