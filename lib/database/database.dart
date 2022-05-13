import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/auth/userdata.dart';
import 'package:untitled1/livreur/historique.dart';
import '../livreur/commande.dart';
import '../livreur/theorder.dart';
//hi

class DatabaseService {
  final String uid ;
  DatabaseService( { required this.uid});


  //Collectoin reference
  final CollectionReference livreurCollection = FirebaseFirestore.instance.collection('livreur');
  // get livreur stream


  // GetUpHistorique
List <Historique> _historiqueList(QuerySnapshot snapshot ){

   return snapshot.docs.map((doc)
   {

     return Historique(date: doc.get("date")??"", heure: doc.get("heure")??'');


   }).toList();

}
  List <TheOrder> _OrderList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      return TheOrder(nomplat:doc.get("nom"),quantite: doc.get("quantite"));


    }).toList();

  }


  List <Commande> _commandeList(QuerySnapshot snapshot){


    return snapshot.docs.map((doc)
    {

      return Commande(LatitudeClient:doc.get("LatitudeClient").toDouble(),LatitudeRestoront: doc.get("LatitudeRestaurant").toDouble(),LongitudeClient :doc.get("LongitudeClient").toDouble() ,LongitudeRestorant: doc.get("LongitudeRestaurant").toDouble(), Nemero: doc.get("Nemero").toDouble() );


    }).toList();

  }


  // edentifi evry time if any changed in document
  Stream<List <Historique>> get livreurhis {
    return livreurCollection.doc(uid).collection("hestorique").snapshots().map((snapshot)=> _historiqueList(snapshot));

  }
  Stream<List <Commande>> get livreurcom {

    return livreurCollection.doc(uid).collection("commandes").snapshots().map((snapshot) => _commandeList(snapshot));

  }

  Stream<List <TheOrder>> get Order {

    return livreurCollection.doc(uid).collection("commandes").doc("commande").collection("plats").snapshots().map((snapshot) => _OrderList(snapshot));

  }

//SetUpHestorique
Future updateHestorique(String s,String v){
  return livreurCollection.doc(uid).collection("hestorique").add({"date":s,"heure":v}) ;
}

//deletecommonde
Future deletecommande(){
  return
    livreurCollection.doc(uid).collection("commandes").doc("commande").delete();
}
//userdata
  Userdata _userdatasnap(DocumentSnapshot snapshot){


  return Userdata(name: snapshot.get("nom").toString(), email: snapshot.get("email").toString(), phone:snapshot.get("phone").toString());
  }

Stream <Userdata> get userData{

  return livreurCollection.doc(uid).snapshots().map((snapshot) =>_userdatasnap(snapshot));
  }
  Exist _existsnap(DocumentSnapshot snapshot){
  return Exist(exist: snapshot.get("exist"));
  }

  Stream <Exist> get exist{
  
  return livreurCollection.doc(uid).collection("commandes").doc("commande").snapshots().map((snapshot) => _existsnap(snapshot));
  }
   setupexist (){
  return livreurCollection.doc(uid).collection("commandes").doc("commande").set({"exist":false});
}
}