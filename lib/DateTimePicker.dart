import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatefulWidget {
  DateTime pickedDateTime;
  Function(DateTime) callback;
  String text;
  CustomDateTimePicker({Key? key, required this.pickedDateTime, required this.text ,required this.callback}) : super(key: key);

  @override
  _CustomDateTimePicker createState() => _CustomDateTimePicker();
}

class _CustomDateTimePicker extends State<CustomDateTimePicker> {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.pickedDateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.pickedDateTime)
      widget.callback(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              InkWell(
                onTap: () => _selectDate(context),
                child: Center(
                  child: Text("${widget.pickedDateTime.toLocal().day}. ${widget.pickedDateTime.toLocal().month}. ${widget.pickedDateTime.toLocal().year}",
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



