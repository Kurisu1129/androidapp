import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'Login.dart';
var mybill;
class BusinessPageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new BusinessPageWidgetState();
  }
}

class BusinessPageWidgetState extends State<BusinessPageWidget>{
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: billTabs.length,
        child: new Scaffold(
      appBar: new AppBar(
        leading:new Icon(
          Icons.search
      ),
        bottom: new TabBar(
            tabs:billTabs.map((billTab billtab){
              return new Tab(
                text: billtab.text
              );
        }).toList(),
          onTap: (int i) async{
switch(i){
  case 0:{
    var httpClient = new HttpClient();
    var uri=new Uri.http('10.0.2.2:8080','/bill/mybill0');
    var request = await httpClient.postUrl(uri);
    Map<String,String> send =new Map();
    send["username"]=currentuser["username"].toString();
    request.headers.set('content-Type', 'application/json');
    request.add(utf8.encode(json.encode(send)));
    var response = await request.close();
    var responsebody = await response.transform(utf8.decoder).join();
    mybill = jsonDecode(responsebody);
    break;
  }
  case 1:{
    var httpClient = new HttpClient();
    var uri=new Uri.http('10.0.2.2:8080','/bill/mybill1');
    var request = await httpClient.postUrl(uri);
    Map<String,String> send =new Map();
    send["username"]=currentuser["username"].toString();
    request.headers.set('content-Type', 'application/json');
    request.add(utf8.encode(json.encode(send)));
    var response = await request.close();
    var responsebody = await response.transform(utf8.decoder).join();
    mybill = jsonDecode(responsebody);
    break;
  }
  case 2:{
    var httpClient = new HttpClient();
    var uri=new Uri.http('10.0.2.2:8080','/bill/mybill2');
    var request = await httpClient.postUrl(uri);
    Map<String,String> send =new Map();
    send["username"]=currentuser["username"].toString();
    request.headers.set('content-Type', 'application/json');
    request.add(utf8.encode(json.encode(send)));
    var response = await request.close();
    var responsebody = await response.transform(utf8.decoder).join();
    mybill = jsonDecode(responsebody);
    break;
  }
}
          },
        ),
        
        title: new TextField(
  decoration: InputDecoration(
    labelText: "请输入查找内容"
  ),
        )
      ),
      body: TabBarView(children: billTabs.map((billTab billtab){
         return tabcontroller(billtab:billtab);
      }).toList())
    )
    );
  }
}

const List<billTab> billTabs = <billTab>[
  billTab(
    text: "全部",
  ),
  billTab(
    text: "我的发布",
  ),
  billTab(
    text:"我的接单"
  )
];

class tabcontroller extends StatelessWidget{
  const tabcontroller({Key key, this.billtab}): super(key: key);
  final billTab billtab;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: mybill.length,
        itemBuilder: (BuildContext,int index) {
          return Card(
            elevation: 5.0,
            child: new Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.local_dining,
                    size: 38.0,
                  ),
                  title: Text(mybill[index]["tname"].toString()),
                  trailing: Text(
                      mybill[index]["tidfinish"] == "0" ? "未完成" : "已完成"),
                ),
                Divider(),
                ListTile(
                  title: Text(mybill[index]["tdate"].toString()),
                  subtitle: Text(mybill[index]["tprice"].toString()),
                )
              ],
            ),
          );
        }

    );
  }
}
class billTab{
  const billTab({ this.text });
  final String text;

}