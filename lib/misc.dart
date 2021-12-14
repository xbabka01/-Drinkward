import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

_create_connection() {
  return PostgreSQLConnection(
      "ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
      5432,
      "d9o5rtu028946m",
      username: "cohzowecdgnnae",
      password:
          "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
      useSSL: true);
}

bool isEmail(String? email) {
  return (email != null) &&
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
}

bool isPassword(String? password) {
  // todo
  return (password != null) && (password.length >= 9);
}

hashPassword(String password) {
  var bytes = utf8.encode(password);
  return sha256.convert(bytes);
}

Future<bool> userVerify(String email, String password) async {
  var connection = _create_connection();
  await connection.open();
  var query = await connection.query(
    'select from "Users" where "email" = @email and "password" = @password',
    substitutionValues: {
      "email": email,
      "password": password,
    },
  );
  connection.close();
  return query.length > 0;
}

Future<bool> login(var context, String email, String password) async {
  if (!isEmail(email)) {
    return false;
  }
  var verified = await userVerify(email, password);

  if (!verified) {
    return false;
  }
  // todo
  var prefs = await SharedPreferences.getInstance();
  // await prefs.setInt('token', 1);
  await prefs.setString('email', email);
  await prefs.setString('password', password);

  return true;
}

Future<bool> logout(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', '');
  await prefs.setString('password', '');

  return true;
}

Future<bool> register(var context, String email, String password) async {
  var connection = _create_connection();
  await connection.open();
  await connection.query(
    "INSERT INTO \"Users\"  (email, password, karma) VALUES (@email, @password, 0)",
    substitutionValues: {
      "email": email,
      "password": password,
    },
  );
  connection.close();
  return true;
}

Future<bool> isLogged(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');

  if (email == null || password == null) {
    return false;
  }

  return userVerify(email, password);
}

Future<String> getEmail(var context) async {
  // todo
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString('email') ?? '';
}

Future<int> getKarma(var context) async {
  var prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');

  var connection = _create_connection();
  await connection.open();
  var query = await connection.query(
    'select "karma" from "Users" where "email" = @email and "password" = @password',
    substitutionValues: {
      "email": email,
      "password": password,
    },
  );
  connection.close();
  if (query.length > 0){
    return int.parse(query[0][0]);
  }

  return 0;
}

Future<bool> changePassword(String old, String new_) async {
  var prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');

  var connection = _create_connection();
  await connection.open();
  var query = await connection.query(
    'select "password" from "Users" where "email" = @email and "password" = @password',
    substitutionValues: {
      "email": email,
      "password": password,
    },
  );
  if (query.length <= 0){
    connection.close();

    return false;
  }
  if (old != query[0][0]){
    connection.close();
    return false;
  }
  await connection.query(
    "UPDATE \"Users\" SET password = @new_psw WHERE \"email\" = @email and \"password\" = @old_psw",
    substitutionValues: {
      "email": email,
      "old_psw": old,
      "new_psw": new_,
    },
  );
  connection.close();
  return true;
  // todo
}
