import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

import 'misc.dart';

Widget textValueListenableBuilder(nofifier) {
  return ValueListenableBuilder<String>(
    valueListenable: nofifier,
    builder: (BuildContext context, String value, _) {
      print("New value is '$value'");
      return Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      );
    },
  );
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final _notifyEmail = ValueNotifier<String>("");
  final _notifyKarma = ValueNotifier<String>("");

  bool showPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Widget result = Scaffold(
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
                        'Profile',
                        style: heading2.copyWith(color: textBlack),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email:',
                        style: heading5.copyWith(color: textBlack),
                      ),
                      textValueListenableBuilder(_notifyEmail),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        'Karma:',
                        style: heading5.copyWith(color: textBlack),
                      ),
                      textValueListenableBuilder(_notifyKarma),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change password',
                          style: heading2.copyWith(color: textBlack),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Old password:',
                          style: heading5.copyWith(color: textBlack),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            controller: oldPasswordController,
                            decoration: InputDecoration(
                              hintText: 'Type your old password',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'New password:',
                          style: heading5.copyWith(color: textBlack),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (!isPassword(value))
                                return 'Password must contain at least 9 characters';
                              return null;
                            },
                            controller: newPasswordController,
                            decoration: InputDecoration(
                              hintText: 'Type your new password',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Confirm password:',
                          style: heading5.copyWith(color: textBlack),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (newPasswordController.text !=
                                  confirmPasswordController.text)
                                return 'Difference between passwords!';
                              return null;
                            },
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: 'Type your new password',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomPrimaryButton(
                    "Change password",
                    () {
                      var valid = _formKey.currentState!.validate();
                      if (!valid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error occurred ')),
                        );
                        return;
                      }
                      changePassword(oldPasswordController.text,
                          newPasswordController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Changing password')),
                      );
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomPrimaryButton(
                    "Logout",
                    () {
                      logout(context).then((value) => Navigator.pop(context));
                    },
                    buttonColor: Colors.red,
                  ),
                ],
              ),
            ),
          ]),
        ));

    getEmail(context).then((value) => _notifyEmail.value = value);
    getKarma(context).then((value) => _notifyKarma.value = value.toString());
    return result;
  }
}
