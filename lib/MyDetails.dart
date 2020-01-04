import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Login.dart';
class MyPageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MyPageWidgetState();
  }
}

class MyPageWidgetState extends State<MyPageWidget>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Align(
            child:Text('我的'),
            alignment: Alignment.center
        )
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding:new EdgeInsets.all(4.0),
            child:Card(
            child: InkWell(
            splashColor: Colors.blue.withAlpha(30),

            child: ListTile(
              title: Text(
                  currentuser["name"].toString(),
              style: TextStyle(
                fontSize: 20.0
              ),
              ),
              subtitle: Text(
                  currentuser["username"].toString(),
                 style: TextStyle(
                 fontSize: 15.0
                 ),
              ),
              leading: new Icon(
                  Icons.sentiment_satisfied,
                size: 50.0,
              )
            ),
          ),
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            )
          ),
          ),
          Container(
            height: 10.0,
          ),
          ListTile(
            title: Text("修改密码"),
            leading: Icon(Icons.vpn_key),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("退出登录"),
            leading: Icon(Icons.power_settings_new),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap:() {
              Navigator.pushNamed(context, "/login");
            },
      ),
          ListTile(
            title: Text("设置"),
            leading: Icon(Icons.build),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("意见反馈"),
            leading: Icon(Icons.assignment),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("关于"),
            leading: Icon(Icons.extension),
            trailing: Icon(Icons.arrow_forward_ios),
          )
        ]
      )
    );
  }
}
