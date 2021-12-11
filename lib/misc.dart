import 'package:shared_preferences/shared_preferences.dart';

bool isEmail(String? email) {
  return (email != null) &&
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
}

bool isPassword(String? password) {
  // todo
  return (password != null) && (password.length >= 9);
}

Future<bool> login(var context, String email, String password) async {
  if (!isEmail(email)) {
    return false;
  }

  // todo
  var prefs = await SharedPreferences.getInstance();
  await prefs.setInt('token', 1);
  await prefs.setString('email', email);
  await prefs.setString('password', password);

  return true;
}

Future<bool> logout(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  await prefs.setInt('token', 0);

  return true;
}

Future<bool> register(var context, String email, String password) async {
  // todo
  return false;
}

Future<bool> isLogged(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  int logged = prefs.getInt('token') ?? 0;
  print('logged');
  print(logged);
  return logged > 0;
}

Future<String> getEmail(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString('email') ?? '';
}

Future<int> getKarma(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  return prefs.getInt('karma') ?? 0;
}

Future<bool> changePassword(String old, String new_) async{
  // todo
  return false;
}
