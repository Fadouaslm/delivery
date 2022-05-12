import 'dart:async';
import 'package:flutter/material.dart';
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

class Acceuil extends StatelessWidget {
  final String etape;
  final destination;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  late Position currentPosition;
  var geoLocator = Geolocator();
  Future<void> locatePosition() async {
    late LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng LatLatPositin = LatLng(position.altitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: LatLatPositin, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Acceuil({Key? key, required this.etape, this.destination}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    int? notif = 5;

    return StreamBuilder<Exist>(
        stream: DatabaseService(uid: user!.uid).exist,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            notif = null;
          }
          if (snapshot.hasData) {
            if (snapshot.data!.exist == false) {
              notif = null;
            } else {
              notif = 5;
            }
          }

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
                  myLocationButtonEnabled: true,

                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controllerGoogleMap.complete(controller);

                    //newGoogleMapController = controller;
                    locatePosition();

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
                                            icon: Icon(
                                              MdiIcons.accountOutline,
                                              color: const Color(0xffB80000),
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
                                        etape,
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
                                            null == destination
                                                ? Livrer()
                                                : destination),
                                  );
                                }))
                        : Container()
                  ],
                )
              ]),
            ),
          );
        });
  }
}

Widget ImageProfile() {
  return Center(
    child: CircleAvatar(
        radius: 40.sp, backgroundImage: AssetImage("images/pic.jpg")),
  );
}
