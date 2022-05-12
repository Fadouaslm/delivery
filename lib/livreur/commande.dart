

class Commande {

  	 final double LongitudeRestorant ;
   final double LatitudeRestoront  ;
    final double LongitudeClient ;
   final double LatitudeClient  ;
    final double Nemero;


    Commande({required this.LatitudeClient,required this.LatitudeRestoront,required this.LongitudeClient,required this.LongitudeRestorant,required this.Nemero,} );
}
class Exist {
  bool exist;
  Exist({required this.exist});

}