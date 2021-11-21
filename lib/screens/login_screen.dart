
import 'package:flutter/material.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id=" login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 
  final _auth= FirebaseAuth.instance;
  bool spinner=false;
  String emailAdress;
  String password;
 
 
  
  @override
  
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                              child: Hero(
                  tag: "logo",
                              child: Container(
                    height: 120.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  emailAdress=value;
                },
                decoration: kTextDecoration.copyWith(hintText: "Enter your email"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                 password=value;
                },
                decoration: kTextDecoration.copyWith(hintText: "Enter your password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(color: Colors.lightBlueAccent,tittle: "Log in",onpressed: ()async{
                setState(() {
                  spinner=true;
                });
                final user= await  _auth.signInWithEmailAndPassword(email: emailAdress, password: password);
                try{
                  if(user!=null){
                  Navigator.pushNamed(context, ChatScreen.id);
                  setState(() {
                    spinner=false;
                  });
                }
                }catch(e){
                  print(e);
                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
