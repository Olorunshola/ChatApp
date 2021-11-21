import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore=FirebaseFirestore.instance;

  User loggedUser;

class ChatScreen extends StatefulWidget {
   static String id="chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController= TextEditingController();
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  final _auth= FirebaseAuth.instance;

  String messageText;
@override
void initState() {
    
    super.initState();
    
  getCurrentUser();
  
  }
  
  void getCurrentUser() async{
    // ignore: await_only_futures
    final user= await _auth.currentUser;
    try{
      if (user!=null){
        loggedUser=user;
      }
    }catch(e){
      print (e);
    }
  }
   
  
  @override
  
   
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blueAccent,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                 
              }),
        ],
        title: Center(child: Text('⚡️Chat')),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilders(),
            
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                      messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                  
                    onPressed: () {
                      messageController.clear();
                      firestore.collection("messages").add({
                        "text": messageText,
                        "sender": loggedUser.email,
                      }
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text,this.sender, this.isme});
  final String text;
  final String sender;
  final bool isme;
  
  
  @override
  Widget build(BuildContext context) {
  
    return Column(crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
    
      children: [ Text(sender,style: TextStyle(fontSize: 15),),
        Padding(
          padding: EdgeInsets.all(10),
          child: Material(
            borderRadius: BorderRadius.only(topLeft: isme?Radius.circular(30):Radius.circular(0),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: isme?Radius.circular(0):Radius.circular(30)
            ),
            elevation: 5.0,
            color: isme? Colors.blueAccent:Colors.white,
            child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Text(text,
              style: TextStyle(fontSize: 15,
              color: isme? Colors.white :Colors.black54),),
            )
          ),
        ),
      ],
    );
  }
}

class StreamBuilders extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: firestore.collection("messages").snapshots(),
              // ignore: missing_return
              builder: (context, snapshot){

                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                {
                  final messages= snapshot.data.docs.reversed;
                  List<MessageBubble> messageWidgets=[];
                  for(var message in messages){
                    
                  final messagetext= message["text"];
                  final messageSender= message["sender"];
                  final currentUser=loggedUser.email;
                  
                
                  final messageBubble=MessageBubble(
                    isme: currentUser==messageSender,
                    sender: messageSender,
                    text: messagetext,
                  );

                  messageWidgets.add(messageBubble);
                  }
          return Expanded(
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              children: messageWidgets,
            ),
          );
                }
              });
  }
}
