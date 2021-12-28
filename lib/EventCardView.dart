import 'package:flutter/material.dart';
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
      child: new Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_drink_sharp,
                  color: Colors.blue,
                  size: 50.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today_sharp),
                          Text(from),
                          Text(" - "),
                          Text(to),
                        ],
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
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
          ),
      ),
    );
  }
}
