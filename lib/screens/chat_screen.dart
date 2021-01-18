import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ScrollController _scrollController = new ScrollController();

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String messageText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//              MessageStream(),
              Container(
                color: Color(0x48f14235),
//                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(color: Color(0xCCFFFFFF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        //Implement send functionality.
                        messageTextController.clear();
                        DateTime now = DateTime.now();
//                        Firestore.instance.collection('messages').add({
//                          'text': messageText,
//                          'sender': loggedInUser.email,
//                          'time': now,
//                        });
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Color(0xCC000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class MessageStream extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: _firestore.snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: CircularProgressIndicator(
//              backgroundColor: Colors.lightBlueAccent,
//            ),
//          );
//        }
//        final messages = snapshot.data.documents.reversed;
//        List<MessageBubble> messageBubbles = [];
//        for (var message in messages) {
//          final messageText = message.data['text'];
//          final messageSender = message.data['sender'];
//          final currentUser = loggedInUser.email;
//          final messageBubble = MessageBubble(
//            sender: messageSender,
//            text: messageText,
//            isMe: currentUser == messageSender,
//          );
//          messageBubbles.add(messageBubble);
//        }
//        return Expanded(
//          child: ListView(
//            controller: _scrollController,
//            reverse: true,
//            shrinkWrap: true,
//            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//            children: messageBubbles,
//          ),
//        );
//      },
//    );
//  }
//}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 13.0,
                fontWeight: FontWeight.w700),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe
                ? Colors.red.withOpacity(0.7)
                : Colors.white.withOpacity(0.7),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 17.0,
                    color: isMe
                        ? Colors.white.withOpacity(0.85)
                        : Colors.red.withOpacity(0.85),
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
