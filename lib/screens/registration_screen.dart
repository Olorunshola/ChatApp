import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
static String id="registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String emailAdress;
  bool spinner=false;
  String password;
final _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:spinner ,
              child: Padding(
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
                decoration: kTextDecoration.copyWith(hintText: "Enter your password")
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(color: Colors.blueAccent,tittle:"Register" ,
              onpressed: ()async{
                setState(() {
                  spinner=true;
                });
                try {
                  final userinfo= await _auth.createUserWithEmailAndPassword(
                    email: emailAdress, password: password);
                    if (userinfo!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        spinner=false;
                      });
                    }
                }catch (e){
                  print(e);
                }
                
              },),
            ],
          ),
        ),
      ),
    );
  }
}
