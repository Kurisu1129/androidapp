import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'package:fluttertoast/fluttertoast.dart';
class UploadBill extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return UploadBillBuild();
  }
}

class UploadBillBuild extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UploadBillState();
  }
}
class UploadBillState extends State<UploadBillBuild>{
  String radioval='waidai';
  String type='外卖代拿上门';
  TextEditingController origin=TextEditingController();
  TextEditingController finalp=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController details=TextEditingController();
  TextEditingController name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
      }),
        title: Text("发布订单"),
      ),
   body: Card(
    child: ListView(
    children: <Widget>[
      ListTile(
        title: Text(type),
        trailing: IconButton(
          icon:Icon(Icons.arrow_forward_ios),
          onPressed: (){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder:(context,state) {
                      return new ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            "订单类型",
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.directions_run
                        ),
                        title: Text(
                          "外卖代拿上门"
                        ),
                        trailing: Radio(value: 'waimai',
                            groupValue: radioval,
                            onChanged: (newval){
                          state((){
                            radioval=newval;
                          });
                          setState(() {
                            type='外卖代拿上门';
                          });
                        }
                            ),
                      ),
                      ListTile(
                        leading: Icon(
                            Icons.directions_run
                        ),
                        title: Text(
                            "食堂/小卖部外带上门"
                        ),
                        trailing: Radio(value: 'waidai',
                            groupValue: radioval,
                            onChanged: (newval){
                              state((){
                                radioval=newval;
                              });
                              setState(() {
                                type="食堂/小卖部外带上门";
                              });
                        }
                              ),
                      )
                    ],
                  );
                      }
                  );
                },
            ).then((val) {
              print(val);
            });})
        ),
    Divider(),
      ListTile(
        leading: Icon(Icons.fastfood),
        title: Text("所需物品"),
        subtitle: TextField(
          controller: name,
          decoration: InputDecoration(
          ),
        ),
      ),
    ListTile(
      leading: Icon(Icons.location_on),
    title: Text("跑腿地点"),
    subtitle: TextField(
      controller: origin,
    decoration: InputDecoration(
    ),
    ),
    ),
    ListTile(
    title: Text("送达地点"),
    subtitle: TextField(
      controller: finalp,
    ),
      leading: Icon(Icons.location_on),
    ),
    ListTile(
    title: Text("报酬金额"),
        leading: Icon(Icons.money_off),
    subtitle: TextField(
      controller: price,
    ),
    ),
    ListTile(
    title: Text("订单备注"),
    leading:  Icon(Icons.edit),
    subtitle: TextField(
      controller: details,
    ),
    ),
      Container(
        height: 50.0
      ),
      Align(
        alignment: Alignment.center,
        child: FloatingActionButton.extended(
        label: Text("发布"),
        onPressed: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var httpclient = new HttpClient();
var uri =new Uri.http("10.0.2.2:8080","/bill/add");
var request = await httpclient.postUrl(uri);
          Map<String,String> send =new Map();
          send["ttype"]= (type=="外卖代拿上门")? 'waimai':'waidai';
          send["tpost"]=currentuser["username"];
          send["toriginplace"]=origin.text;
          send["tfinalplace"]=finalp.text;
          send["tprice"]=price.text;
          send["tdetails"]=details.text;
          send["tname"]=name.text;
          send["tisfinish"]="0";
          request.headers.set('content-Type', 'application/json');
          request.add(utf8.encode(json.encode(send)));
          var response = await request.close();
          var responsebody=await response.transform(utf8.decoder).join();
          var result = responsebody;
          Fluttertoast.showToast(
              msg: "发布成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              textColor: Colors.black,
              fontSize: 16.0
          );
          Navigator.pop(context);
        },
      )
      )
    ],
    )
    )
    );
}

}