import 'package:corona_app/pages/newsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getUpdateData() async {
    Response response = await get('https://nepalcorona.info/api/v1/data/nepal');
    //print(response.body);
    var data = json.decode(response.body);
    return data;
    //print(data);
  }

  @override
  void initState() {
    super.initState();
    getUpdateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Text(
              'Latest Corona Update Nepal',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            FutureBuilder(
                future: getUpdateData(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: Text('Loading....'));
                  } else {
                    return GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: <Widget>[
                        // Text('Latest Update Of Corona Nepal'),
                        Card(
                          color: Colors.red[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Positive Cases',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data['tested_positive'].toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.green[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Negative Cases',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data['tested_negative'].toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.orange[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Recovered',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data['recovered'].toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.brown[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Dead',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data['deaths'].toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.lime[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Quarantained',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data['quarantined'].toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'In Isolation',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data['in_isolation'].toString()),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => NewsPage()));
              },
              child: Text('ClickehereforNews'),
            ),
          ],
        ),
      ),
    );
  }
}
