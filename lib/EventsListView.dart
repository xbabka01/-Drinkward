import 'package:drinkward/EventCardView.dart';
import 'package:flutter/material.dart';
import 'package:drinkward/EventDetailView.dart';
import 'package:postgres/postgres.dart';
import 'package:drinkward/models/models.dart';
import 'package:intl/intl.dart';

var results;

class EventsListView extends StatefulWidget {
  @override
  _EventsListView createState() => _EventsListView();
}

class _EventsListView extends State<EventsListView> {

  Future<List<Event>> getAllRecords() async {
    var connection = PostgreSQLConnection("ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
        5432,
        "d9o5rtu028946m",
        username: "cohzowecdgnnae",
        password: "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
        useSSL: true
    );
    await connection.open();
    List<List<dynamic>> results = await connection.query("SELECT * FROM public.\"Events\"");
    List<List<dynamic>> pubs = await connection.query("SELECT p.id, p.name, p.google_id, p.city, p.street, p.street_number, ep.events_id "
        "FROM public.\"Pubs\" as p "
        "INNER JOIN public.\"EventsPubs\" ep "
        "ON p.id = ep.pubs_id");
    connection.close();
    List<Event> eventList = [];
    for (final row in results) {
      List<Pub> pubList = [];
      for (final r in pubs) {
        if (row[0] == r[6]) {
          pubList.add(Pub(r[0], r[1], r[2], r[3], r[4], r[5], []));
        }
      }
      eventList.add(Event(row[0], row[1], row[2], row[3], row[4], row[5], pubList));
    }
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Event>>(
        future: getAllRecords(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (_, int position) {
                String from = DateFormat('dd.MM.yyyy').format(snapshot.data?[position].startDate ?? new DateTime(0));
                String to = DateFormat('dd.MM.yyyy').format(snapshot.data?[position].endDate ?? new DateTime(0));
                String about = snapshot.data?[position].name ?? "Not specified description";
                String name = snapshot.data?[position].name ?? "Not specified name";
                int likes = 0; // item[];
                int dislikes = 0; // item[];
                String barName =  "";
                if(snapshot.data?[position].pub.isEmpty ?? true) {
                  barName = "Not specified bar";
                } else {
                  barName = snapshot.data?[position].pub[0].name ?? "Not specified bar";
                }

                return new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new EventDetailView(snapshot.data?[position].id ?? 0))
                    );
                  },
                  child: new EventCardView(from, to, about, name, likes, dislikes, barName),
                );
              }
            );
          } else {
            return new CircularProgressIndicator();
          }
        },
      ),
    );
  }
}