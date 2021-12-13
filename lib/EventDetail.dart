import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  // bool passwordVisible = false;

  // void togglePassword() {
  //   setState(() {
  //     passwordVisible = !passwordVisible;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(children: [
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Finlandia 2+1',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_sharp),
                      Text(
                        "21.8.2020 - 28.8.2020",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp),
                      Text(
                        "u Karly",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Row(
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed vel lectus. Donec odio tempus molestie, porttitor ut, iaculis quis, sem. Etiam egestas wisi a erat. Class aptent taciti sociosqu ad litora torquent per conubia nostra. Aliquam erat volutpat.",
                          maxLines: 20,
                          style: TextStyle(
                            fontSize: 10
                          ),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.justify,
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
