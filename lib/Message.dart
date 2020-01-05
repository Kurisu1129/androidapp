import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'Chat.dart';
import 'Login.dart';
class MEssagePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:MessagePageWidget(),
      routes: {
        "/chatwindow":(context)=>Chat()
        }
    );
  }
}
class MessagePageWidget extends StatefulWidget{
 static final WebSocketChannel channel=new IOWebSocketChannel.connect("ws://10.0.2.2:8080/websocket/"+currentuser["username"]);
  @override
  State<StatefulWidget> createState() {
    return new MessagePageWidgetState();
  }
}


class MessagePageWidgetState extends State<MessagePageWidget>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Align(
            child:Text('消息'),
    alignment: Alignment.center
      )
      ),
      body: new ListView(
        children: <Widget>[
          ListTile(
            leading:new Container(
               child:ClipOval(
                 child: new Image(
                image:AssetImage("images/3.png"),
                     height: 60,
                     width: 60,
                     fit: BoxFit.cover
              ),
               )
            ),
                title:new Text("跑腿员xxxxx"),
            subtitle: new Text("帮忙多买一瓶可乐，谢谢。"),
              onTap:(){
                     Navigator.pushNamed(context, "/chatwindow");
    }
      )
    ]
      )
    );
  }
}