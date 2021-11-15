import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class BarCardView extends StatefulWidget {
  @override
  _BarCardView createState() => _BarCardView();
}

class _BarCardView extends State<BarCardView> {

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: double.infinity,
      child: Card(
        child: Container(
            width: double.infinity,
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
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.house_rounded,
                        size: 70,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "u Karly",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 20,
                          ),
                          Text(
                            "Brno",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        Row(
                            children: [
                              Text("Finlandia 2+1")
                            ]
                        ),
                        Row(
                            children: [
                              Text("Finlandia 2+1")
                            ]
                        ),
                        Row(
                            children: [
                              Text("Finlandia 2+1")
                            ]
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          )
      ),
    );
  }
}
