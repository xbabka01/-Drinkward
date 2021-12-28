import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:drinkward/models/models.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

int eventID = 0;

class EventDetailView extends StatefulWidget {
  @override
  _EventDetailView createState() => _EventDetailView();

  EventDetailView(int id) {
    eventID = id;
  }
}

class _EventDetailView extends State<EventDetailView> {
  GoogleMapController? _controller;
  //TODO: create fnc to add pub markers
  Set<Marker> _markers = {};

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

  Future<Event> getEventDetails() async {
    await connection.open();
    List<List<dynamic>> results = await connection.query("SELECT * FROM public.\"Events\" WHERE id =" + eventID.toString() );
    List<List<dynamic>> pubs = await connection.query("SELECT p.id, p.name, p.google_id, p.city, p.street, p.street_number "
        "FROM public.\"Pubs\" as p "
        "INNER JOIN public.\"EventsPubs\" ep "
        "ON p.id = ep.pubs_id "
        "WHERE ep.events_id =" + eventID.toString() );
    connection.close();
    List<Pub> pubsList = [];
    for (final row in pubs) {
      pubsList.add(Pub(row[0], row[1], row[2], row[3], row[4], row[5], []));
    }
    return Event(results[0][0], results[0][1], results[0][2], results[0][3], results[0][4], results[0][5], pubsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildEventDetail(),
    );
  }

  Widget buildEventDetail(){
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
              child:FutureBuilder<Event>(
                future: getEventDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return new Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              snapshot.data?.name ?? "Event",
                              style: TextStyle(fontSize: 35),
                            ), // TODO: get from db
                            const SizedBox(width: 8, height: 50),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today_sharp),
                            Text(
                              DateFormat('dd.MM.yyyy').format(snapshot.data?.startDate ?? new DateTime(0)),
                              style:TextStyle(fontSize: 16),
                            ),
                            Text(" - "),
                            Text(
                              DateFormat('dd.MM.yyyy').format(snapshot.data?.endDate ?? new DateTime(0)),
                              style:TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8, height: 35),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: snapshot.data?.pub.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: Icon(Icons.house_rounded),
                                title: Text(snapshot.data?.pub[index].name ?? "Not specified name",
                                style: TextStyle(fontSize: 20),), //TODO: maybe add address ??
                            );
                          },
                        ),
                        ),
                        Row(
                            children:<Widget>[
                              Text(
                                "Description:",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 8, height: 35),
                            ]
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                                snapshot.data?.about ?? "",
                                style: TextStyle(fontSize: 14)
                            ), // Todo: get description from db
                            const SizedBox(width: 8, height: 35)
                          ],
                        ),
                        // TODO: dynamic request, after click show dynamic map
                        Image.network('https://maps.googleapis.com/maps/api/staticmap?center=Brno%2C-95.7192&zoom=15&size=600x1200&key=AIzaSyCFZHjTIyXiZFrGod-54GMIltNYcH160nk'),
                      ],
                    );
                  }
                  else if (snapshot.hasError) {
                    return new Text("${snapshot.error}");
                  }

                  else {
                    return new CircularProgressIndicator();
                  }
                }
              ),

            ),
          ),
        ],
      ),);
  }
}

