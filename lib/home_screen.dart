import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'position_list.dart';
import 'boxes.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapController googleMapController;
  Position? position;
  Set<Marker> markers = {};
  BitmapDescriptor? mapMaker;

  myLocation() async {
    position = await _getPosition();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                position?.latitude as double, position?.longitude as double),
            zoom: 14)));
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        draggable: true,
        infoWindow: const InfoWindow(title: "divyang", snippet: 'test'),
        position: LatLng(
            position?.latitude as double, position?.longitude as double)));
    setState(() {});
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Please unable location permission");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Please unable location permission");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Please unable location permission");
    }
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  void initState() {
    super.initState();
    myLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            final location = LocationData(
                latitude: position?.latitude as double,
                longitude: position?.longitude as double);

            final box = Boxes.getBox();
            box.add(location);
          },
        ),
        centerTitle: true,
        title: const Text('Maps'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/list'),
              icon: const Icon(Icons.library_books_outlined))
        ],
      ),
      body: GoogleMap(
          compassEnabled: true,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          trafficEnabled: true,
          initialCameraPosition:
              const CameraPosition(target: LatLng(10.7, -122.4), zoom: 12),
          markers: markers,
          onMapCreated: (GoogleMapController controller) =>
              googleMapController = controller),
    );
  }
}
