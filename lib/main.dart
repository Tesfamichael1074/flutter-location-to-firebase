import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'uitrial.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}


class MyAppState extends State<MyApp>{
  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;

  Location location = new Location();
  String error;

  @override
  void initState(){
    super.initState();

    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();

    locationSubscription = location.onLocationChanged().listen((Map<String,double> result){setState(() {
      currentLocation = result;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
          appBar: AppBar(title: Text('Ping Location'),), body: 
          Center(child: 
            Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Text('Lat/Lng:${currentLocation['latitude']}/${currentLocation['longitude']}', style: 
              TextStyle(fontSize: 20.0, color: Colors.blueAccent),),
              FlatButton.icon(
                icon: Icon(Icons.cloud_upload),
                color: Colors.lightGreen,
                label: Text("Upload location"),
                onPressed: () {
                    Firestore.instance
                .collection('location')
                .add({
                  "latitude": currentLocation['latitude'].toString(),
                  "longitude": currentLocation['longitude'].toString()
              });
                },
              ),
            ],)
          ,),
      ),
      debugShowCheckedModeBanner: false,
    );
  }


void initPlatformState() async{
Map<String,double> myLocation;
try{
  myLocation = await location.getLocation();
  error = "";
}on PlatformException catch(e){
    if (e.code == 'PERMISSION_DENIED')
          error = 'permission denied';
    else if(e.code == 'PERMISSION_DENIED_NEVER_ASK')
          error = 'permission denied please enable it form the app settings';
    //myLocation = null;

}

setState(() {
  currentLocation = myLocation;
});
}
}

class Record {
 final int longitude;
 final int latitude;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       longitude = map['longitude'],
       latitude = map['latitude'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$latitude:$longitude>";
}