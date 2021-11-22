import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  singleCard(image, title, summary, url) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(image),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(summary),
          RaisedButton(
            onPressed: () {
              launchURL(url);
            },
            child: Text('ShowDetails'),
          ),
        ],
      ),
    );
  }

  Future getLatestNews() async {
    Response response = await get(
        Uri.decodeFull('https://nepalcorona.info/api/v1/news'),
        headers: {'Accept': 'application/json'});

    //print(response.body);
    var data = json.decode(response.body);
    return data;
    //print(data);
  }

  Future<Null> Refreshlist() async {
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getLatestNews(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: Refreshlist,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return singleCard(
                        snapshot.data['data'][index]['image_url'],
                        snapshot.data['data'][index]['title'],
                        snapshot.data['data'][index]['summary'],
                        snapshot.data['data'][index]['url'],
                      );
                    }),
              );
            }
          }),
    );
  }

  void launchURL(String webURL) async {
    var url = '$webURL';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '$url cannot be launced sorry!!';
    }
  }
}
