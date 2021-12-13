import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BarDetailView extends StatefulWidget {
  @override
  _BarDetailView createState() => _BarDetailView();
}

class _BarDetailView extends State<BarDetailView> {
  GoogleMapController? _controller;
  //TODO: create fnc to add pub markers
  Set<Marker> _markers = {};
  // TODO: into config
  final String googleMapsApiKey ='AIzaSyCFZHjTIyXiZFrGod-54GMIltNYcH160nk';

  // TODO: delete after get from db
  String _barName = "U Karly";
  String _eventLoc = "Brno";
  String _eventName = "Finlandia 2+1";
  String _eventDate = "21.8.2020 - 28.8.2020";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            IconButton(
              padding:
              EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 10),
              alignment: Alignment.topRight,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.undo),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          _barName,
                          style: TextStyle(fontSize: 35),
                        ), // TODO: get from db
                        const SizedBox(width: 8, height: 50),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on_sharp, size: 25,),
                        Text("Bayerova 42, 602 00, Brno",
                          style:TextStyle(fontSize: 16),
                        ), //TODO: get address from db
                        const SizedBox(width: 8, height: 35),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Events",
                          style: TextStyle(fontSize: 20),
                        ), //TODO: get location from db
                        const SizedBox(width: 8, height: 35),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        // TODO: get dynamicly from db
                        children: [
                          Row(
                            children: <Widget>[
                              Icon(Icons.house_rounded, size: 25,),
                              Text(
                                _barName,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.calendar_today_sharp, size: 25),
                              Text(
                                _eventDate,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.house_rounded, size: 25),
                              Text(
                                _barName,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.calendar_today_sharp, size: 25),
                              Text(
                                _eventDate,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.house_rounded),
                              Text(
                                _barName,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.calendar_today_sharp),
                              Text(
                                _eventDate,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // TODO: dynamic request, after click show dynamic map
                    Image.network('https://maps.googleapis.com/maps/api/staticmap?center=Brno%2C-95.7192&zoom=15&size=600x800&key=AIzaSyCFZHjTIyXiZFrGod-54GMIltNYcH160nk'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
