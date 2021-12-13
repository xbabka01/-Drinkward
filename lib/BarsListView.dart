import 'package:drinkward/BarCardView.dart';
import 'package:flutter/material.dart';

class BarsListView extends StatefulWidget {
  @override
  _BarsListView createState() => _BarsListView();
}

class _BarsListView extends State<BarsListView> {
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
          // TODO: get list of all cards
          child: ListView(children: [
            BarCardView(),
            BarCardView(),
            BarCardView(),
            BarCardView(),
            BarCardView(),
            BarCardView(),
            BarCardView(),
            BarCardView(),
            BarCardView(),
          ]),
        ));
  }
}
