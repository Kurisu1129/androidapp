import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Bill.dart';
import 'MyDetails.dart';
import 'Message.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
Map currentuser=new Map();
class LoginM extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home:LoginMount(),
      routes: {
        "/index":(context)=>MyApp()
      },
    );
  }
}
class LoginMount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPage();
  }
}
class LoginPage extends State<LoginMount>{
  // This widget is the root of your application.
  TextEditingController usernamecont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(

     home: new Scaffold(
       backgroundColor: Colors.white,
     appBar:  new AppBar(
       elevation: 0.0,
       title: new Center(
         child: new Text(
           "登录",
         ),
       ),
     ),
     body: Column(
       children: <Widget>[
         Container(
           height: 100.0,
         ),
         Center(
           child: Text(
               "DD打饭",
             style: TextStyle(
               fontSize: 40.0,
               color: Colors.blue
     )
   )
     ),
         Container(
           height: 50.0,
         ),
         Center(
             child:Container(
                 width: 300.0,
                 child:TextField(
                   controller: usernamecont,
                     decoration: InputDecoration(
                         labelText: "账号",
                         icon: Icon(
                             Icons.supervisor_account,
                         size: 30.0,
                         )
                     )
                 )
             )
         ),
         Center(
             child:Container(
                 width: 300.0,
                 child:TextField(
                   controller: passwordcont,
                     decoration: InputDecoration(
                         labelText: "密码",
                         icon: Icon(
                             Icons.vpn_key,
    size: 30.0,
    )
    )
   )
   )
    ),
         Container(
           height: 30.0,
         ),
         Center(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               FlatButton(
                 onPressed: ()  async{
                   String username=usernamecont.text.toString();
                   String password=passwordcont.text.toString();
                   var httpClient = new HttpClient();
                   var uri=new Uri.http('10.0.2.2:8080','/login/check');
                   var request = await httpClient.postUrl(uri);
                   Map<String,String> send =new Map();
                   send["username"]=username;
                   send["password"]=password;
                   request.headers.set('content-Type', 'application/json');
                   request.add(utf8.encode(json.encode(send)));
                   var response = await request.close();
                   var responsebody = await response.transform(utf8.decoder).join();
                   Map respdata = jsonDecode(responsebody);
                   print(respdata);
                   if (respdata['data'].toString()=="true"){
                   SharedPreferences prefs =await SharedPreferences.getInstance();
                   send["isLogin"]="true";
                   prefs.setString("userinfo", json.encode(respdata));
                   currentuser=json.decode(prefs.get("userinfo"));
                     Navigator.pushNamed(context, "/index");
                   }else{
                     return showDialog(context: context,
                     barrierDismissible: false,
                      builder: (BuildContext context) {
                       return AlertDialog(
                           title:Text("错误"),
                         content: Text("用户名或密码错误"),
                         actions: <Widget>[
                           FlatButton(
                             child: Text('重新输入'),
                             onPressed: () {
                               Navigator.of(context).pop();
                             },
                           ),
                         ],
                       );
                      });
                   }
                 },
                 child: Text("登录",
                 style: TextStyle(
                   fontSize: 20.0,
                   color: Colors.blue
                 ),),
               ),
               FlatButton(
                 onPressed: () {
                 },
                 child: Text("注册",
                   style: TextStyle(
                       fontSize: 20.0,
                     color: Colors.blue
                   ),),
               )
             ],
           )
    )
   ]
    )
     )
   );
  }
}
