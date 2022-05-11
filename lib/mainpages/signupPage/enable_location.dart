import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/location_model.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/main.dart';
import 'package:lets_connect/mainpages/signupPage/userdetails.dart';
import 'package:lottie/lottie.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Lottie.asset(
                    "assets/images/orange_map.json",
                    repeat: true,
                    // animate: true,
                    fit: BoxFit.fitWidth,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                child: const Text(
                  "Allow Your Location",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 90),
                child: const Text(
                  "Want to see nearby events and connect with people in your area? Enable location services to save time and avoid typing those tedious zip codes.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    //fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    getLocation();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please wait...")));
                  },
                  child: const Text(
                    'Enable Location Services',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: const Text(''),
            toolbarHeight: 50,
            leading: TextButton(
              onPressed: () async {
                signOutFromGoogle();
                UserPreferences.resetUser();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SetUpInfo()),
                  );
                },
                child: const Text('Skip'),
              ),
            ], // You can add title here
            backgroundColor:
                Colors.orange.withOpacity(0.0), //You can make this transparent
            elevation: 0, //No shadow
          ),
        )
      ]),
    );
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      print(placeMark);
      setState(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SetUpInfo()),
        );
      });
    }
  }
}
