import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DeviceCamera(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
    );
  }
}

class DeviceCamera extends StatefulWidget {
  @override
  _DeviceCameraState createState() => _DeviceCameraState();
}

class _DeviceCameraState extends State<DeviceCamera> {
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    selectFromCamera() async {
      cameraFile=await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {});
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Device Camera"),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 400.0,
                    width: 400.0,
                    child: cameraFile == null
                        ? Center(child: new Text('No Image'))
                        : Center(child: new Image.file(cameraFile)),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: selectFromCamera,
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      size: 24,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 40.0,
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: Text(
                'Device Camera',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: Icon(
                Icons.camera,
                size: 28.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Google Maps',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: Icon(
                Icons.map,
                size: 25.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMaps()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {

  GoogleMapController mapController;

  final LatLng _center = const LatLng(17.9833, -76.8000);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Maps'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      );
  }
}