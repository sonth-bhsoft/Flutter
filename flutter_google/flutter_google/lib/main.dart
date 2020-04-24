import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  GoogleMapController mapController;
  String sreachAddr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onCreated,
              initialCameraPosition:
              CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 10.0),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,

            ),
            Positioned(
              top: 30.0,
              right: 15.0,

              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter Adress",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: searchNavigate,
                        iconSize: 30.0,
                      )),
                  onChanged: (val) {
                    setState(() {
                      sreachAddr = val;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  searchNavigate() {
    Geolocator().placemarkFromAddress(sreachAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
          LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 14.4746)));
    });
  }





}
