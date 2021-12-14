import 'package:drinkward/DateTimePicker.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:substring_highlight/substring_highlight.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  DateTime newStartDate = DateTime.now();
  DateTime newEndDate = DateTime.now();
  String newDescription = "";
  String name = "";
  int? addToPub;
  List<String> pubs = [];
  var connection = PostgreSQLConnection("ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
      5432,
      "d9o5rtu028946m",
      username: "cohzowecdgnnae",
      password: "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
      useSSL: true
  );

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
    await connection.open();
    List<List<dynamic>> results = await connection.query("SELECT name FROM public.\"Pubs\"");
    List<String> pubs = [];
    for (final row in results) {
      pubs.add(row[0]);
    }
    return pubs;
  }

  Future addEvent() async {
    List<List<dynamic>> results = await connection.query("SELECT id FROM public.\"Pubs\" WHERE google_id = \'" + "jhkjk21321jhhgjh" + "\'");
    if (results.isEmpty || results[0].isEmpty) {
      // TODO poloha a ostatne
      // TODO addToPub
      List<dynamic> _ = await connection.query("INSERT INTO public.\"Pubs\" (google_id) VALUES (\'" + "jhkjk21321jhhgjh" + "\')");
      List<dynamic> pubID = await connection.query("SELECT id FROM public.\"Pubs\" WHERE google_id = \'" + addToPub.toString() + "\'");
      String quer = "INSERT INTO public.\"Events\" (\"from\", \"to\", \"about\", \"name\") VALUES (\'" + newStartDate.toString().split(" ")[0] + "\', \'" + newEndDate.toString().split(" ")[0] + "\', \'" + newDescription + "\', \'" + name + "\')";
      List<List<dynamic>> s = await connection.query(quer);
      List<dynamic> eventID = await connection.query("SELECT MAX(id) FROM public.\"Events\"");
      List<dynamic> ss = await connection.query("INSERT INTO public.\"EventsPubs\" (pubs_id, events_id) VALUES (\'" + pubID.toString() + "\', \'" + eventID.toString() + "\')");
    } else {
      String quer = "INSERT INTO public.\"Events\" (\"from\", \"to\", \"about\", \"name\") VALUES (\'" + newStartDate.toString().split(" ")[0] + "\', \'" + newEndDate.toString().split(" ")[0] + "\', \'" + newDescription + "\', \'" + name + "\')";
      List<List<dynamic>> _ = await connection.query(quer);
      List<dynamic> eventID = await connection.query("SELECT MAX(id) FROM public.\"Events\"");
      int val = results[0][0];
      List<dynamic> ss = await connection.query("INSERT INTO public.\"EventsPubs\" (pubs_id, events_id) VALUES (\'" + val.toString() + "\', \'" + eventID[0][0].toString() + "\')");
    }
    connection.close();
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

  final TextEditingController _typeAheadController = TextEditingController();
  late TextEditingController controller;


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
                connection.close();
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
                    height: 20,
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
                              hintText: '*Event Name',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (String? value) {
                              if (value != null) {
                                name = value;
                              }
                            },
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
                              hintText: 'Event description',
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
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child:
                          Autocomplete(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              } else {
                                return pubs.where((word) => word
                                    .toLowerCase()
                                    .contains(textEditingValue.text.toLowerCase()));
                              }
                            },
                            optionsViewBuilder:
                                (context, Function(String) onSelected, options) {
                              return Material(
                                elevation: 4,
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return ListTile(
                                        // title: Text(option.toString()),
                                        title: SubstringHighlight(
                                          text: option.toString(),
                                          term: controller.text,
                                          textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        // subtitle: Text(""),
                                        onTap: () {
                                          onSelected(option.toString());
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) => Divider(),
                                    itemCount: options.length,
                                  ),
                              );
                            },
                            onSelected: (selectedString) {
                              print(selectedString);
                            },
                            fieldViewBuilder:
                                (context, controller, focusNode, onEditingComplete) {
                              this.controller = controller;
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                onEditingComplete: onEditingComplete,
                                decoration: InputDecoration(
                                  hintText: '*Pub name',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              );
                            },
                          )
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
