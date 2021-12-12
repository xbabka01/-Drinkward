import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: isChecked ? null : Border.all(color: textGrey, width: 1.5),
        ),
        width: 20,
        height: 20,
        child: isChecked
            ? Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

const Color primaryBlue = Color(0xff2972ff);
const Color textBlack = Color(0xff222222);
const Color textGrey = Color(0xff94959b);
const Color textWhiteGrey = Color(0xfff1f1f5);

TextStyle heading2 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

TextStyle heading5 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle heading6 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle regular16pt = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

class CustomPrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;
  final GestureTapCallback? onTap;

  CustomPrimaryButton(
    this.textValue,
    this.onTap, {
    this.buttonColor = Colors.blueAccent,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14.0),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Text(
                textValue,
                style: heading5.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextFormField customTextFormField(
  String hintText,
  TextEditingController controller,
  bool? visible,
  void Function()? toogle,
  FormFieldValidator<String>? validator,
) {
  return TextFormField(
    controller: controller,
    obscureText: visible == false,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: heading6.copyWith(color: textGrey),
      suffixIcon: visible != null
          ? IconButton(
              color: textGrey,
              splashRadius: 1,
              icon: Icon(visible == true
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined),
              onPressed: toogle,
            )
          : null,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}

ValueListenableBuilder<String> textValueListenableBuilder(
  ValueListenable<String> nofifier,
) {
  return ValueListenableBuilder<String>(
    valueListenable: nofifier,
    builder: (BuildContext context, String value, _) {
      print("New value is '$value'");
      return Text(
        value,
        style: heading6.copyWith(color: textGrey),
        textAlign: TextAlign.left,
      );
    },
  );
}
