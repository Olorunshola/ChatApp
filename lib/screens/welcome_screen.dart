import 'package:flutter/material.dart';
import './login_screen.dart';
import './registration_screen.dart';
import "package:animated_text_kit/animated_text_kit.dart";
import 'package:flash_chat/component/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WelcomeScreen extends StatefulWidget {

  static String id="welcome_screen";


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
AnimationController controller;
Animation animation;
FirebaseFirestore firestore=FirebaseFirestore.instance;
  @override
  
  void initState() {
    super.initState();
    
    controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this);
  //     animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
  controller.forward();
  animation=ColorTween(begin: Colors.blue,end: Colors.white).animate(controller);
  
  controller.addListener(() {
    setState(() {
      
    });
   });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//   void getMessages() async{
// // final Stream<QuerySnapshot> firestore= FirebaseFirestore.instance.collection("messsages").snapshots();
// final messages =firestore.collection("messages").get();

//   }

  @override
  
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 50,
                  ),
                ),
                TyperAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(color: Colors.lightBlueAccent,
            tittle: "Log in",onpressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(color: Colors.blueAccent,tittle: "Register",
            onpressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },),
          
          ],
        ),
      ),
    );
  }
}

