import 'package:drinkward/EventCardView.dart';
import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class EventsListView extends StatefulWidget {
  @override
  _EventsListView createState() => _EventsListView();
}

class _EventsListView extends State<EventsListView> {
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
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
            EventCardView(),
          ]),
        ));
  }
}
