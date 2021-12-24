import 'package:flutter/material.dart';
import 'EventDetailView.dart';
import 'package:drinkward/misc.dart';

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

  //TODO: get from db
  int _likes = 0;
  int _dislikes = 0;
  bool _likesPressed = false;
  bool _dislikesPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventDetailView())
                );
              },
              leading: Icon(
                Icons.local_drink_sharp,
                color: Colors.blue,
                size: 50.0,
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
                      Text("Hospoda u Karly, Brno"), //TODO: get location from db
                      const SizedBox(width: 8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon : const Icon(Icons.thumb_up_off_alt_outlined),
                        color: Colors.green,
                        onPressed:() {
                         setState(() {
                           // TODO: on second pres --,
                           // TODO: check if user is logged in
                           if (_likesPressed) {
                             _likes -= 1;
                           }
                           else{
                             _likes += 1;
                           }
                             _likesPressed = !_likesPressed;
                         });
                        }
                      ),
                      Text('$_likes'),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(Icons.thumb_down_off_alt_outlined),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            // TODO: check user logged in
                            if (_dislikesPressed) {
                              _dislikes -= 1;
                            }
                            else{
                              _dislikes += 1;
                            }
                            _dislikesPressed = !_dislikesPressed;
                          });
                        },
                      ),
                      Text('$_dislikes'),
                      const SizedBox(width: 4),
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
