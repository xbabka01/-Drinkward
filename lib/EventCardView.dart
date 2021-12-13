import 'package:drinkward/EventDetail.dart';
import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class EventCardView extends StatefulWidget {
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
              leading: Icon(
                Icons.local_drink_sharp,
                color: Colors.blue,
                size: 50.0,
              ),
              title: Text('Finlandia 2+1'), //TODO: get name from db
              subtitle: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.calendar_today_sharp),
                      Text("21.8.2020 - 28.8.2020"), //TODO: get date from db
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
