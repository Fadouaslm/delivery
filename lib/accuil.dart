import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'dart:core';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:untitled1/database/database.dart';
import 'package:untitled1/profil.dart';
import 'auth/user.dart';
import 'livrer.dart';
import 'livreur/commande.dart';

class Acceuil extends StatefulWidget {
  final String etape;
  final destination;
  Acceuil({Key? key, required this.etape, this.destination}) : super(key: key);

  @override
  State<Acceuil> createState() => _AcceuilState();
}

double _destLatitude = 0;
// Destination Longitude
double _destLongitude = -0;
// Markers to show points on the map
double long = 0, lat = 0;
Map<MarkerId, Marker> markers = {};

PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

class _AcceuilState extends State<Acceuil> {
  String sex = "";
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;


  late StreamSubscription<Position> positionStream;

  @override
  void initState() {

    checkGps();

    /// add origin marker origin marker
    _addMarker(
      LatLng(lat, long),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),

      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!12");
    print("$_destLatitude $_destLongitude");
    _getPolyline();

    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude;
    lat = position.latitude;

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude;
      lat = position.latitude;

      setState(() {
        //refresh UI on update
      });
    });
  }
  getLocation2() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude;
    lat = position.latitude;



    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude;
      lat = position.latitude;


    });
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _googleMapController;

  late GoogleMapController newGoogleMapController;

  late Position currentPosition;

  var geoLocator = Geolocator();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    int? notif = 5;


    ;
    return StreamBuilder<Exist>(

        stream: DatabaseService(uid: user!.uid).exist,
        builder: (context, snapshot) {
          String s=widget.etape;
          if (snapshot.hasData == false) {
            notif = null;
          }
          if (snapshot.hasData) {
            if (snapshot.data!.exist == false) {
              notif = null;
            } else {
              notif = 5;
              if (s == 'Aucune commande') {
                s = 'vous avez un commande';
              }
            }
          }
          print(s);
          if (s== 'Aller au restaurant') {

            print("22222222222222222222222222222222222222222");
            _destLatitude =
                DatabaseService(uid: user.uid).commande().LatitudeRestoront.toDouble();
            _destLongitude =
                DatabaseService(uid: user.uid).commande().LongitudeRestorant.toDouble();
          } else if (s == 'Aller au client') {
            _destLatitude = DatabaseService(uid: user.uid).commande().LatitudeClient.toDouble();
            _destLongitude =
                DatabaseService(uid: user.uid).commande().LongitudeClient.toDouble();
          } else {
            print("111111111111111111111111111111111111111");
            _destLatitude = lat;
            _destLongitude = long;
          }
          print("/////////////////////////////////////////////////////////");

          print(_destLongitude);
          print(_destLatitude);
          _addMarker(
            LatLng(_destLatitude, _destLongitude),

            "destination",
            BitmapDescriptor.defaultMarkerWithHue(90),
          );

          getLocation2();
          print("555555555555555555555555555555555555555555");
          print(long);
          return SafeArea(
            child: Scaffold(
              drawer: profile(),
              body: Stack(children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(35.6609610106784,
                        -0.6652752343750112), // ihdathiyat Oron
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                  markers: Set<Marker>.of(markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController = controller;
                    _controller.complete(controller);
                  },
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 12.0.h, horizontal: 12.0.w),
                            decoration: BoxDecoration(
                                color: const Color(0xffF9F8F8),
                                borderRadius: BorderRadius.circular(36.w)),
                            alignment: Alignment.topCenter,
                            height: 59.h,
                            width: 336.w,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 3.0),
                                        height: 33.03.h,
                                        width: 21.w,
                                        child: Center(
                                          child: IconButton(
                                            icon: sex == "M"
                                                ? Icon(
                                                    MdiIcons.accountOutline,
                                                    color:
                                                        const Color(0xffB80000),
                                                    size: 35.sp,
                                                  )
                                                : Icon(
                                                    MdiIcons.humanFemaleGirl,
                                                    color:
                                                        const Color(0xffB80000),
                                                    size: 35.sp,
                                                  ),
                                            onPressed: () {
                                              Scaffold.of(context).openDrawer();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 23.w,
                                  ),
                                  Container(
                                      height: 33.04.h,
                                      width: 0.5.w,
                                      child: const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 0.5,
                                      )),
                                  Container(
                                    height: 33.04.h,
                                    width: 258.w,
                                    child: Center(
                                      child: Text(
                                        s,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15.sp,
                                          color: Color(0xffB80000),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                ])),
                      ],
                    ),
                    ////////////////////////////////////////////////////////////////////
                    notif != null
                        ? Padding(
                            padding:
                                EdgeInsets.fromLTRB(31.w, 630.h, 31.w, 8.h),
                            child: ConfirmationSlider(
                                sliderButtonContent: Icon(
                                  Icons.double_arrow,
                                  color: const Color(0xffB80000),
                                  size: 27.sp,
                                ),
                                foregroundColor: Colors.transparent,
                                height: 50.h,
                                width: 297.0.w,
                                backgroundColor: Colors.white,
                                iconColor: Color(0xffF9F8F8),
                                text: " Suivant",
                                textStyle: TextStyle(
                                  color: Color(0xffB80000),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                                onConfirmation: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            null == widget.destination
                                                ? Livrer()
                                                : widget.destination),
                                  );
                                }))
                        : Container()
                  ],
                )
              ]),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                onPressed: () => _googleMapController!
                    .animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(lat, long), // ihdathiyat Oron
                    zoom: 15,
                  ),
                )),
                child: Icon(Icons.center_focus_strong),
              ),
            ),
          );
        });
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCNCIcIpC47x2pTyRmT6jmLqo919HISBCo",
      PointLatLng(lat, long),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    print("$_destLatitude $_destLongitude");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
