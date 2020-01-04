import 'package:flutter/material.dart';
import 'UploadBill.dart';
import 'dart:io';
import 'dart:convert';
var allBill;
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home:HomePageWidget(),

    );
  }
}
class HomePageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HomePageWidgetState();
  }
}

class HomePageWidgetState extends State<HomePageWidget>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Align(
          child: Text('首页'),
          alignment: Alignment.center
        )
      ),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 220.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              child:Column(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.note_add,
                  color: Colors.blue,
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "/upload");
                },
                iconSize: 150.0,
              ),
              Text("发布订单",
              style: TextStyle(
                fontSize: 15.0
              ),)
            ],
        ),
              alignment: Alignment.center,
      ),
            Align(
                child:Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                          Icons.assignment_returned,
                        color: Colors.blue,
                      ),
                      onPressed: () async{
                        var httpClient = new HttpClient();
                        var uri=new Uri.http('10.0.2.2:8080','/bill/getAll');
                        var request = await httpClient.getUrl(uri);
                        request.headers.set('content-Type', 'application/json');
                        var response = await request.close();
                        var responsebody = await response.transform(utf8.decoder).join();
                        allBill=jsonDecode(responsebody);
                        Navigator.pushNamed(context, "/get");
                      },
                      iconSize: 150.0,
                    ),
                    Text("接受订单",
                      style: TextStyle(
                          fontSize: 15.0
                      ),)
                  ],
                ),
              alignment: Alignment.center
            ),
    ]
    )
    )
    );
  }
}