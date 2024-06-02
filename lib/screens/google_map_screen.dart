import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;
  LatLng _currentPosition =
      LatLng(-6.200000, 106.816666); // Default location (Jakarta)
  LatLng _otherPosition =
      LatLng(-6.1751, 106.8650); // Example location (Monas, Jakarta)

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
    _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  double _calculateDistance(LatLng start, LatLng end) {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    return distanceInMeters / 1000; // Convert to kilometers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Locations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _controller = controller;
                // Move camera to current location once map is created
                if (_currentPosition.latitude != 0 &&
                    _currentPosition.longitude != 0) {
                  _controller
                      ?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
                }
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
              markers: {
                Marker(
                    markerId: MarkerId('current'), position: _currentPosition),
                Marker(markerId: MarkerId('other'), position: _otherPosition),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Distance: ${_calculateDistance(_currentPosition, _otherPosition).toStringAsFixed(2)} km',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
