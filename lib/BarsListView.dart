import 'package:drinkward/BarCardView.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:drinkward/BarDetailView.dart';

var results;

class BarsListView extends StatefulWidget {
  @override
  _BarsListView createState() => _BarsListView();
}

class _BarsListView extends State<BarsListView> {

  Future<List> getAllRecords() async {
    var connection = PostgreSQLConnection("ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
        5432,
        "d9o5rtu028946m",
        username: "cohzowecdgnnae",
        password: "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
        useSSL: true
    );
    await connection.open();
    results = await connection.query("SELECT * FROM public.\"Pubs\"");
    await connection.close();
    return results.toList();
  }

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
                //if ( item.isNotEmpty ) {
                  String p1 = item[1];
               // };
                String p2 = item[3];
                return new GestureDetector(
                    onTap:() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BarDetailView(item[0]))
                      );
                    },
                  child: BarCardView(p1, p2),
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