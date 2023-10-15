import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;
  String posicion = "";

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      posicion =
          "Mi posición: Latidud ${position.latitude} y Longitud: ${position.longitude}";
      print(myPosition);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 500,
                        width: 400,
                        child: myPosition == null
                            ? const SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : FlutterMap(
                                options: MapOptions(
                                  center: myPosition,
                                  minZoom: 10,
                                  maxZoom: 25,
                                  zoom: 18,
                                  onTap: (tapPosition, point) => () {},
                                ),
                                nonRotatedChildren: [
                                  RichAttributionWidget(
                                    attributions: [
                                      TextSourceAttribution(
                                        'OpenStreetMap contributors',
                                        onTap: () => launchUrl(Uri.parse(
                                            'https://openstreetmap.org/copyright')),
                                      ),
                                    ],
                                  ),
                                ],
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName:
                                        'dev.fleaflet.flutter_map.example',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                          point: myPosition!,
                                          builder: (context) {
                                            return const Icon(
                                              Icons.location_on,
                                              color: Color(0xFFa2221e),
                                              size: 40,
                                            );
                                          })
                                    ],
                                  )
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        posicion,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ))));
  }
}
