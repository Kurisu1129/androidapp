import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'dart:io';
import 'dart:convert';
import 'Login.dart';
import 'package:fluttertoast/fluttertoast.dart';
class GetBill extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBillBuild();
  }
}
class GetBillBuild extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GetBillState();
  }
}
class GetBillState extends State<GetBillBuild>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
appBar: AppBar(
  leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios
      ),
      onPressed: (){
        Navigator.pop(context);
      }),
  title: Text("接受订单")
),
      body: ListView.builder(
        itemCount: allBill.length,
        itemBuilder: (BuildContext,int index){
          return new Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("订单酬劳"),
                  trailing: Text(allBill[index]["tprice"].toString(),
                    style: TextStyle(
                        fontSize: 30.0
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("商品名称"),
                  trailing: Text(allBill[index]["tname"].toString(),
                    style: TextStyle(
                        fontSize: 20.0
                    ),

                  ),
                ),
                ListTile(
                  title: Text("跑腿地点"),
                  trailing: Text(allBill[index]["toriginplace"].toString(),
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                ListTile(
                  title: Text("送达地点"),
                  trailing: Text(allBill[index]["tfinalplace"].toString(),
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                ListTile(
                  title: Text("订单备注"),
                  trailing: Text(allBill[index]["tdetails"].toString(),
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                Align(alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () async{
                      var httpclient = new HttpClient();
                      var uri =new Uri.http("10.0.2.2:8080","/bill/getbill");
                      var request = await httpclient.postUrl(uri);
                      Map send = new Map();
                      send["tget"]=currentuser["username"].toString();
                      send["tid"]=allBill[index]["tid"].toString();
                      request.headers.set('content-Type', 'application/json');
                      request.add(utf8.encode(json.encode(send)));
                      var response = await request.close();
                      var result = response.transform(utf8.decoder).join();
                      Fluttertoast.showToast(
                          msg: "接单成功",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                      Navigator.pop(context);
                    },
                    child: Text("接单",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          height: 1.0
                      ),),

                  ),
                ),
              ],
            ),
          );
        },

            )
    );
  }
}