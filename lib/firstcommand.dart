import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/commande.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project/Myicons.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


// import 'Myicons.dart';

class EnterFirstCommand extends StatefulWidget {
  const EnterFirstCommand({Key? key})
      : super(key: key); // gued vers le resterant

  @override
  State<EnterFirstCommand> createState() => _EnterFirstCommandState();

}
// Starting point latitude
double _originLatitude = 35.6609610106784;   // 35.6609610106784, -0.6652752343750112
// Starting point longitude
double _originLongitude = -0.6652752343750112;
// Destination latitude
double _destLatitude = 35.66;
// Destination Longitude
double _destLongitude = -0.6652752343750112;
// Markers to show points on the map
Map<MarkerId, Marker> markers = {};

PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};


class _EnterFirstCommandState extends State<EnterFirstCommand> {
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    /// add origin marker origin marker
    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            // markers: Marker(markerId: MarkerId('')),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  35.6609610106784, -0.6652752343750112), // ihdathiyat Oron
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
              _controller.complete(controller);
            },
          ),
          Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, //bach nba3ad binathom
            //crossAxisAlignment: CrossAxisAlignment.,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 12.0.h,
                          horizontal: 12.0.w), // ba3adna 3la l7afa min lfo9
                      decoration: BoxDecoration(
                          color: Color(0xffF9F8F8),
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
                                        MdiIcons
                                            .accountOutline, //account-outline
                                        color: Color(0xffB80000),
                                        size: 35.sp,
                                      ),
                                      onPressed: () {},
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
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                )),
                            Container(
                              //margin: EdgeInsets.symmetric(horizontal:0.0.w ,vertical: 15.h),
                              //color: Colors.red,
                              height: 33.04.h,
                              width: 258.w,
                              child: Center(
                                child: Text(
                                  'Aller au restaurant',
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 31.w),
                child: ConfirmationSlider(
                  sliderButtonContent: Icon(
                    Icons.double_arrow,
                    color: Color(0xffB80000),
                    size: 27.sp,
                  ),
                  foregroundColor: Colors.transparent,
                  height: 50.h,
                  width: 297.0.w,
                  backgroundColor: Colors.white,
                  iconColor: Color(0xffF9F8F8),
                  text: " Suivant",
                  textStyle: const TextStyle(
                    color: Color(0xffB80000),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  onConfirmation: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => commande()),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
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
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
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

