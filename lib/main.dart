import 'package:drinkward/AddEventView.dart';
import 'package:drinkward/BarsListView.dart';
import 'package:drinkward/EventsListView.dart';
import 'package:drinkward/login.dart';
import 'package:drinkward/profile.dart';
import 'package:flutter/material.dart';
import 'package:drinkward/MapView.dart';
import 'package:postgres/postgres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drinkward',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Drinkward'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var connection = PostgreSQLConnection("ec2-52-209-246-87.eu-west-1.compute.amazonaws.com",
      5432,
      "d9o5rtu028946m",
      username: "cohzowecdgnnae",
      password: "8b02dd03e907d484f22e131a74b40c4d087cdc4a50f9f22bee4d02c6506e285d",
      useSSL: true
  );

  Future operation() async {

    await connection.open();
    List<List<dynamic>> results = await connection.query("SELECT about FROM public.\"Events\"");

    for (final row in results) {
      var name = row[0];
      print(name);
    }
    print("Connected to DB");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  operation();
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.calendar_today_rounded)),
                  Tab(icon: Icon(Icons.house_rounded)),
                  Tab(icon: Icon(Icons.map_rounded)),
                ],
              ),
              title: Row(children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    constraints: BoxConstraints(maxWidth: 300),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      ),
                    )),
                new IconButton(
                  icon: const Icon(Icons.person_rounded),
                  alignment: Alignment.centerRight,
                  tooltip: 'Person profile',
                  onPressed: () {
                    isLogged(context).then(
                      (result) {
                        if (!result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ])),
          body: TabBarView(
            children: [
              // Icon(Icons.calendar_today_rounded),
              Stack(
                children: <Widget>[
                  EventsListView(),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: EdgeInsets.all(40),
                          child: IconButton(
                            tooltip: 'Add event',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEvent()));
                            },
                            icon: Icon(
                              Icons.add_circle_outline_sharp,
                              size: 70,
                              color: Colors.blue,
                            ),
                          )))
                ],
              ),
              BarsListView(),
              MapView(),
            ],
          ),
        ),
      ),
    );
  }
}
