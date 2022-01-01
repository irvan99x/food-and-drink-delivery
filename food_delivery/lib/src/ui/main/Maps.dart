import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/src/ui/widget/maps/AppBarMaps.dart';
import 'package:food_delivery/src/utility/FadeAnimation.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';
import 'package:food_delivery/src/utility/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Maps extends StatefulWidget {
  final VoidCallback getAddress;

  const Maps({
    Key key,
    this.getAddress,
  }) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;

  final Set<Marker> _markers = {};

  List<Placemark> placemark;

  double lat;
  double lng;
  String _alamat;
  bool isSave;
  bool isSet;

  @override
  void initState() {
    super.initState();
    isSave = false;
    isSet = false;

    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMaps(
        context: context,
      ),
      body: latLng == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: latLng,
                      zoom: 15.0,
                    ),
                    markers: _markers,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    onTap: (position) {
                      setState(() {
                        isSet = false;

                        _markers.clear();

                        lat = position.latitude;
                        lng = position.longitude;

                        _markers.add(
                          Marker(
                            markerId: MarkerId(
                                "${position.latitude}, ${position.longitude}"),
                            icon: BitmapDescriptor.defaultMarker,
                            position: position,
                            onTap: () {
                              setState(() {
                                isSet = true;
                              });
                            },
                          ),
                        );
                      });
                    },
                  ),
                ),
                if (isSave)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                if (isSet)
                  Positioned(
                    bottom: 55.0,
                    left: 0.1,
                    right: 0.1,
                    child: FadeAnimation(
                      0.5,
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                elevation: 1.0,
                                color: colorTeal,
                                borderRadius: BorderRadius.circular(5.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5.0),
                                  onTap: () {
                                    _setAlamat();
                                  },
                                  child: Container(
                                    width: 100.0,
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        'PILIH LOKASI INI',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Material(
                              elevation: 1.0,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5.0),
                                onTap: () {
                                  setState(() {
                                    isSet = false;
                                  });
                                },
                                child: Container(
                                  width: 40.0,
                                  padding: EdgeInsets.all(6.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position _position) {
          if (_position != null) {
            if (mounted) {
              setState(() {
                latLng = LatLng(
                  _position.latitude,
                  _position.longitude,
                );
              });
            }
          }
        });
        break;
    }
  }

  _setAlamat() async {
    setState(() {
      isSave = true;
    });

    try {
      placemark = await Geolocator().placemarkFromCoordinates(lat, lng);

      if (mounted) {
        setState(() {
          _alamat = placemark[0].name.toString() +
              ", " +
              placemark[0].subLocality.toString() +
              ", " +
              placemark[0].locality.toString() +
              ", " +
              placemark[0].administrativeArea.toString() +
              ", " +
              placemark[0].country.toString();
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }

    print(_alamat);

    SessionManager().setSessionAddress(lat, lng, _alamat);

    setState(() {
      isSave = false;
    });

    Navigator.pop(context);
    widget.getAddress();
  }
}
