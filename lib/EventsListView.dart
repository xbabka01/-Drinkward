import 'package:drinkward/EventCardView.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';



var results;

class EventsListView extends StatefulWidget {
  @override
  _EventsListView createState() => _EventsListView();
}

class _EventsListView extends State<EventsListView> {
  // bool passwordVisible = false;

  // void togglePassword() {
  //   setState(() {
  //     passwordVisible = !passwordVisible;
  //   });
  // }

  var connection = new PostgreSQLConnection("ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
      5432,
      "d9o5rtu028946m",
      username: "cohzowecdgnnae",
      password: "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
      useSSL: true
  );

  Future<List> getAllRecords() async {
    await connection.open();
    results = await connection.query("SELECT * FROM public.\"Events\"");
    await connection.close();
    return results.toList();
  }

  //Future<List> _users =
  //getAllRecords(); // CALLS FUTURE

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List>(
        future: getAllRecords(),
        //initialData: [0],
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, int position) {
                var item = snapshot.data![position];
               // var parsedDate = DateTime.parse(item[1]);
                String from = item[1].toString();
                String to = item[2].toString();
                String about = item[3];
                String name = item[5];
                return Card(
                  child: EventCardView(from,to,about,name),
                );
              },
            );
          }
          else {
            return new CircularProgressIndicator();
          }
        },
      ),
    );
  }
}