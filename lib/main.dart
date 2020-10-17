import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;        //to handle http Request
import 'dart:async';                            //for async function
import 'dart:convert';                          //to convert the http response in JSON format


//https://reqres.in/api/users?page=2

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map data;
  List userData;

  Future getData() async{
    http.Response response = await http.get("https://reqres.in/api/users?page=2");
    // debugPrint(response.body);
    data=json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    //debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Data Through HTTP"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          //scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.redAccent,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData[index]["avatar"]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}