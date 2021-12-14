import 'package:flutter/material.dart';

String from = "";
String to = "";
String about = "";
String name = "";

class EventCardView extends StatefulWidget {
  EventCardView (String param1, String param2, String param3, String param4) {
    from = param1;
    to = param2;
    about = param3;
    name = param4;
  }
  @override
  _EventCardView createState() => _EventCardView();
}

class _EventCardView extends State<EventCardView> {
  // bool passwordVisible = false;

  // void togglePassword() {
  //   setState(() {
  //     passwordVisible = !passwordVisible;
  //   });
  // }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.local_drink_sharp,
                color: Colors.blue,
                size: 40.0,
              ),
              title: Text(name),
              subtitle: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.calendar_today_sharp),
                      Text("13.12.2021 - 24.12.2021"),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_on_sharp),
                      Text("Hospoda u Karly, Brno"),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.thumb_up_off_alt_outlined,
                        color: Colors.green,
                      ),
                      Text("56x"),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.thumb_down_off_alt_outlined,
                        color: Colors.red,
                      ),
                      Text("20x"),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
