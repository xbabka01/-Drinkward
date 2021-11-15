import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class BarCardView extends StatefulWidget {
  @override
  _BarCardView createState() => _BarCardView();
}

class _BarCardView extends State<BarCardView> {
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
              title: Text('Finlandia 2+1'),
              subtitle: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.calendar_today_sharp),
                      Text("21.8.2020 - 28.8.2020"),
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
