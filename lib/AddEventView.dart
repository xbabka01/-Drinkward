import 'package:drinkward/DateTimePicker.dart';
import 'package:drinkward/globals.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';


class AddEvent extends StatefulWidget {
  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  DateTime newStartDate = DateTime.now();
  DateTime newEndDate = DateTime.now();
  String newDescription = "";
  int? addToPub;
  List<String> pubs = [];

  @override
  void initState() {
    super.initState();
    this.getPubs().then((List<String> result){
      setState(() {
        pubs = result;
      });
    });
  }

  changeStartDate(newStartDate) {
    setState(() {
      this.newStartDate = newStartDate;
    });
  }
  changeEndDate(newEndDate) {
    setState(() {
      this.newEndDate = newEndDate;
    });
  }

  Future<List<String>> getPubs() async {
    // TODO google maps api?
    List<List<dynamic>> results = await connection.query("SELECT name FROM public.\"Pubs\"");
    List<String> pubs = [];
    for (final row in results) {
      pubs.add(row[0]);
    }
    return pubs;
  }

  Future addEvent() async {
    String quer = "INSERT INTO public.\"Events\" (\"from\", \"to\", \"about\", \"pub_id\") VALUES (\'" + newStartDate.toString().split(" ")[0] + "\', \'" + newEndDate.toString().split(" ")[0] + "\', \'" + newDescription + "\', \'" + addToPub.toString() + "\')";
    List<List<dynamic>> _ = await connection.query(quer);
  }

  int findPubIndex(String selected) {
    int i = 0;
    for (final item in pubs) {
        if (item == selected) {
          return i;
        }
        i++;
    }
    return -1;
  }


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
                              hintText: '*Event description',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (String? value) {
                              if (value != null) {
                                newDescription = value;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                          Autocomplete<String>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              return pubs.where((String option) {
                                return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                              });
                            },
                            onSelected: (String selection) {
                              debugPrint('You just selected $selection');
                              addToPub = findPubIndex(selection);
                            },
                          ),
                        SizedBox(
                          height: 32,
                        ),
                        CustomDateTimePicker(
                          pickedDateTime: newStartDate,
                          text: '*Event start date: ',
                          callback: changeStartDate,
                        ),
                        CustomDateTimePicker(
                          pickedDateTime: newEndDate,
                          text: '*Event end date: ',
                          callback: changeEndDate,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  CustomPrimaryButton(
                    "Add",
                        () {
                      print("adding");
                      addEvent();
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
        )
    );
  }
}
