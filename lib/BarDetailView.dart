import 'package:drinkward/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

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

  var connection = PostgreSQLConnection("ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
      5432,
      "d9o5rtu028946m",
      username: "cohzowecdgnnae",
      password: "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
      useSSL: true
  );

  void initState() {
    super.initState();
  }

  // TODO: delete after get from db
  String _barName = "U Karly";
  String _eventLoc = "Brno";
  String _eventName = "Finlandia 2+1";
  String _eventDate = "21.8.2020 - 28.8.2020";

  Future<Pub> getBarDetails(int id) async {
    await connection.open();
    List<List<dynamic>> results = await connection.query("SELECT * FROM public.\"Pubs\" WHERE id =" + id.toString() );
    List<List<dynamic>> events = await connection.query(  "SELECT e.id, e.from, e.to, e.about, e.rated_id, e.name "
        "FROM public.\"Events\" as e "
        "INNER JOIN public.\"EventsPubs\" ep "
        "ON e.id = ep.events_id "
        "WHERE ep.pubs_id =" + id.toString() );
    connection.close();
    List<Event> eventsList = [];
    for (final row in events) {
      eventsList.add(Event(row[0], row[1], row[2], row[3], row[4], row[5], []));
    }
    return Pub(results[0][0], results[0][1], results[0][2], results[0][3], results[0][4], results[0][5], eventsList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBarDetail(),
    );
  }

  Widget buildBarDetail() {
    return SafeArea(
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
              child: FutureBuilder<Pub>(
                future: getBarDetails(0), //TODO: id dynamicly
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return new Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              snapshot.data?.name ?? "Pub",
                              style: TextStyle(fontSize: 35),
                            ),
                            const SizedBox(width: 8, height: 50),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on_sharp, size: 25,),
                            Text(
                              (snapshot.data?.street ?? "Street") + " " + (snapshot.data?.streetNumber.toString() ?? "0") + ", "+ (snapshot.data?.city ?? "City"),
                              style:TextStyle(fontSize: 16),
                            ),
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
                          child: ListView.builder(
                            itemCount: snapshot.data?.events.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: Icon(Icons.local_drink_sharp, size: 25,),
                                title: Text(snapshot.data?.events[index].name ?? "Not specified name"), //TODO: maybe add address ??
                                subtitle: Text(
                                    (DateFormat('dd.MM.yyyy').format(snapshot.data?.events[index].startDate ?? new DateTime(0))) + (DateFormat('dd.MM.yyyy').format(snapshot.data?.events[index].endDate ?? new DateTime(0)))
                                ),
                              );
                            },
                          ),
                        ),
                        // TODO: dynamic request, after click show dynamic map
                        Image.network('https://maps.googleapis.com/maps/api/staticmap?center=Brno%2C-95.7192&zoom=15&size=600x800&key=AIzaSyCFZHjTIyXiZFrGod-54GMIltNYcH160nk'),
                      ],
                    );
                  }
                  else if (snapshot.hasError) {
                    return new Text("${snapshot.error}");
                  }

                  else {
                    return new CircularProgressIndicator();
                  }
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}
