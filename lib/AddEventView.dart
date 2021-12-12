import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
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
            IconButton(
              padding:
              EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 10),
              alignment: Alignment.topRight,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.undo),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Event',
                        style: heading2.copyWith(color: textBlack),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '*Event name',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '*City',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '*Event start date',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '*Event end date',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomPrimaryButton(
                    "Add",
                        () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
