import 'package:drinkward/BarCardView.dart';
import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
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
            BarCardView(),
          ]),
        ));
  }
}
