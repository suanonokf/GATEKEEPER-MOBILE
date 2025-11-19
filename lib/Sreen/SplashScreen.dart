import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:namer_app/Sreen/Home.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  @override
  void initState(){
    super.initState();
    logInVerification();
  }
  Future<void> logInVerification()async{
    await Future.delayed(Duration(seconds: 2));
    Future<String?> read = secureStorage.read(key: 'accountToken');
    if(read.toString()!="Instance of 'Future<String?>'"){
      print("Token: $read");
      Navigator.pushNamed(context, '/Home');
    }
    else{
      Navigator.pushNamed(context, '/LogIn');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/splashImage.png',
                width: MediaQuery.of(context).size.width/2.6,
                height: MediaQuery.of(context).size.height/6,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      );
  }
}