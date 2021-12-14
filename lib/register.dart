import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

import 'misc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

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
              padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: customTextFormField(
                            'Email',
                            emailController,
                            null,
                            null,
                            (value) {
                              if (!isEmail(value))
                                return 'Invalid email address!';
                              return null;
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
                          child: customTextFormField(
                            'Password',
                            passwordController,
                            passwordVisible,
                            togglePassword,
                            (value) {
                              if (!isPassword(value))
                                return 'Password must contain at least 9 characters';
                              return null;
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
                          child: customTextFormField(
                            'Password Confirmation',
                            confirmPasswordController,
                            passwordConfrimationVisible,
                            () {
                              setState(() {
                                passwordConfrimationVisible =
                                    !passwordConfrimationVisible;
                              });
                            },
                            (value) {
                              if (passwordController.text !=
                                  confirmPasswordController.text)
                                return 'Difference between passwords!';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomCheckbox(),
                      // SizedBox(
                      //   width: 12,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'By creating an account, you agree to our',
                            style: regular16pt.copyWith(color: textGrey),
                          ),
                          Text(
                            'Terms & Conditions',
                            style: regular16pt.copyWith(color: primaryBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomPrimaryButton(
                    'Register',
                    () {
                      var valid = _formKey.currentState!.validate();
                      if (!valid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error occurred ')),
                        );
                        return;
                      }
                      register(context, emailController.text,
                              passwordController.text)
                          .then(
                        (value) {
                          if (value) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Registering sucseeded. Now login.'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to register.'),
                              ),
                            );
                          }
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registering'),
                        ),
                      );
                      return;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: regular16pt.copyWith(color: textGrey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: Text(
                          'Login',
                          style: regular16pt.copyWith(color: primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
