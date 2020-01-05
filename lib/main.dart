import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Bill.dart';
import 'MyDetails.dart';
import 'Message.dart';
import 'Login.dart';
import 'Chat.dart';
import 'UploadBill.dart';
import 'GetBill.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main(){

  runApp(new MaterialApp(home:LoginM()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return  new MaterialApp(
      home: BottomNavigationWidget(),
        routes: {
          "/chatwindow":(context)=>Chat(channel:MessagePageWidget.channel),
          "/upload":(context)=>UploadBill(),
          "/get":(context)=>GetBill(),
          "/index":(context)=>MyApp(),
          "/login":(context)=>LoginM()
        }
    );

  }
}
class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationWidgetState();
  }
}
class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> pages = new List();
  @override
//initState是初始化函数，在绘制底部导航控件的时候就把这3个页面添加到list里面用于下面跟随标签导航进行切换显示
  void initState() {
    pages
      ..add(HomePageWidget())
      ..add(BusinessPageWidget())
      ..add(MessagePageWidget())
      ..add(MyPageWidget());
  }
  @override
  Widget build(BuildContext context) {
    /*
    返回一个脚手架，里面包含两个属性，一个是底部导航栏，另一个就是主体内容
     */
    return new Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //底部导航栏的创建需要对应的功能标签作为子项，这里我就写了3个，每个子项包含一个图标和一个title。
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: new Text(
                '首页',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
              ),
              title: new Text(
                '订单',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
              ),
              title: new Text(
                '消息',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mood,
              ),
              title: new Text(
                '我的',
              )),
        ],
        //这是底部导航栏自带的位标属性，表示底部导航栏当前处于哪个导航标签。给他一个初始值0，也就是默认第一个标签页面。
        currentIndex: _currentIndex,
        //这是点击属性，会执行带有一个int值的回调函数，这个int值是系统自动返回的你点击的那个标签的位标
        onTap: (int i) async{
          //进行状态更新，将系统返回的你点击的标签位标赋予当前位标属性，告诉系统当前要显示的导航标签被用户改变了。
          if(i==1) {
            var httpClient = new HttpClient();
            var uri = new Uri.http('10.0.2.2:8080', '/bill/mybill0');
            var request = await httpClient.postUrl(uri);
            Map<String, String> send = new Map();
            send["username"] = currentuser["username"].toString();
            request.headers.set('content-Type', 'application/json');
            request.add(utf8.encode(json.encode(send)));
            var response = await request.close();
            var responsebody = await response.transform(utf8.decoder).join();
            mybill = jsonDecode(responsebody);
          }
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}