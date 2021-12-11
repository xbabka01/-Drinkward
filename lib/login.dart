import 'package:drinkward/register.dart';
import 'package:drinkward/widget/common.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
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
                        'Login',
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
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null ||
                                  !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value)) {
                                return 'Invalid email address!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                            controller: passwordController,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: heading6.copyWith(color: textGrey),
                              suffixIcon: IconButton(
                                color: textGrey,
                                splashRadius: 1,
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: togglePassword,
                              ),
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
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomCheckbox(),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Remember me', style: regular16pt),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomPrimaryButton(
                    "Login",
                    () {
                      var valid = _formKey.currentState!.validate();
                      if (!valid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid input')),
                        );
                        return;
                      }

                      // final name = nameController.text;
                      // final password = passwordController.text;

                      Navigator.pop(context);
                    },
                  ),
                  // SizedBox(
                  //   height: 24,
                  // ),
                  // Center(
                  //   child: Text(
                  //     'OR',
                  //     style: heading6.copyWith(color: textGrey),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 24,
                  // ),
                  // CustomPrimaryButton(
                  //   'Login with Google',
                  //   () {
                  //     Navigator.pop(context);
                  //   },
                  //   buttonColor: Color(0xfffbfbfb),
                  //   textColor: textBlack,
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: regular16pt.copyWith(color: textGrey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Text(
                          'Register',
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
