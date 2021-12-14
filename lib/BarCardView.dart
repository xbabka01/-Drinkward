import 'package:flutter/material.dart';
import 'BarDetailView.dart';

class BarCardView extends StatefulWidget {
  @override
  _BarCardView createState() => _BarCardView();
}

class _BarCardView extends State<BarCardView> {

  // TODO: get from db and delete
  String _barName = "U Karly";
  String _eventLoc = "Brno";
  String _eventName = "Finlandia 2+1";

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: double.infinity,
      child: GestureDetector(
        onTap:() {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BarDetailView())
          );
        },
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
                        size: 50.0,
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
                            "$_barName",
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
                            "$_eventLoc",
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
                              // TODO: get all events of one bar from db
                              Text('$_eventName')
                            ]
                        ),
                        Row(
                            children: [
                              Text('$_eventName')
                            ]
                        ),
                        Row(
                            children: [
                              Text('$_eventName')
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
    ));
  }
}
