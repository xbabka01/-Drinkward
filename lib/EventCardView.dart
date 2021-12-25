import 'package:flutter/material.dart';
import 'EventDetailView.dart';
import 'package:intl/intl.dart';


String from = "";
String to = "";
String about = "";
String name = "";
int likes = 0;
int dislikes = 0;
String barName = "";

class EventCardView extends StatefulWidget {
  EventCardView (String param1, String param2, String param3, String param4, int likesParam, int dislikesParam, String barNameParam) {
    from = param1.split(" ")[0];
    to = param2.split(" ")[0];
    about = param3;
    name = param4;
    likes = likesParam;
    dislikes = dislikesParam;
    barName = barNameParam;
  }
  @override
  _EventCardView createState() => _EventCardView();
}

enum UserRated{
  liked,
  disliked,
  none,
}

final DateFormat formatter = DateFormat('yyyy-MM-dd');

class _EventCardView extends State<EventCardView> {
  //TODO: get from db
  UserRated userRate = UserRated.none;

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
                  Container(
                    width:  400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.calendar_today_sharp),
                        Text(from),
                        Text(" - "),
                        Text(to),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_on_sharp),
                      Text(barName), //TODO: get location from db
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
                           switch (userRate) {
                             case UserRated.none: {
                               userRate = UserRated.liked;
                               likes++;
                             }
                             break;
                             case UserRated.liked: {
                               userRate = UserRated.none;
                               likes--;
                             }
                             break;
                             case UserRated.disliked: {
                               userRate = UserRated.liked;
                               likes++;
                               dislikes--;
                             }
                           }
                         });
                        }
                      ),
                      Text('$likes'),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(Icons.thumb_down_off_alt_outlined),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            // TODO: check user logged in
                            switch (userRate) {
                              case UserRated.none: {
                                userRate = UserRated.disliked;
                                dislikes++;
                              }
                              break;
                              case UserRated.liked: {
                                userRate = UserRated.disliked;
                                dislikes++;
                                likes--;
                              }
                              break;
                              case UserRated.disliked: {
                                userRate = UserRated.none;
                                dislikes--;
                              }
                            }
                          });
                        },
                      ),
                      Text('$dislikes'),
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
