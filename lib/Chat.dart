import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Bill.dart';
import 'MyDetails.dart';
import 'Message.dart';
import 'Login.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Chat extends StatefulWidget{
  final WebSocketChannel channel;
  Chat({this.channel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatWindow();
  }
}
class ChatWindow extends State<Chat>{
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages =<ChatMessage>[];

  void _handleSubmitted(String text) {
    if(_textController.text.isNotEmpty){
      widget.channel.sink.add(_textController.text);
    }
    _textController.clear();
    ChatMessage sendmessage = new ChatMessage(message:text);
    setState(() {
      _messages.insert(0,sendmessage);
    });

  }
  Widget _buildTextComposer() {
    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
            children: <Widget> [
              new Flexible(
                  child: new TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: new InputDecoration.collapsed(hintText: '发送消息'),
                  )
              ),
    new Container(
    margin: new EdgeInsets.symmetric(horizontal: 4.0),
    child: new IconButton(
    icon: new Icon(Icons.send),
    onPressed: () => _handleSubmitted(_textController.text)),
    )
            ]
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return new Scaffold(
        appBar: AppBar(
          title: Text("跑腿员xxxxx"),
          leading: new IconButton(
            icon:Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: new Column(
            children: <Widget>[
              new Flexible(
                  child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => _messages[index],
                    itemCount: _messages.length,
                  )
              ),
              new Divider(height: 1.0),
              new Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: _buildTextComposer(),
              )
            ]
        )
      );
  }
}
 String _name = currentuser["username"];
class ChatMessage extends StatelessWidget{
  ChatMessage({this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(message),
                    )
                  ]
              )
            ]
        )
    );
  }
}