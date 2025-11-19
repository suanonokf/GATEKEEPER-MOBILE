import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Sreen/Home.dart';
import 'package:namer_app/Sreen/LogIn.dart';
import 'package:provider/provider.dart';

import '../Service/AppTheme.dart';

class SettingScreen extends StatelessWidget{
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Future<void> _confirmLogOut(BuildContext context) async{
    bool? willLogOut=await showDialog<bool>(
        context: context,
        builder: (context)=> AlertDialog(
          backgroundColor: CupertinoColors.white,
          shadowColor: CupertinoColors.inactiveGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          content: Text("Do you want to log out ?",style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 20)),),
          title: Text("Confirm Log Out",style: GoogleFonts.notoSans(textStyle: TextStyle(color:AppTheme().getHeaderColor(),fontWeight:FontWeight.bold,fontSize: 25)),),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context,true);
                },
                child: Text("Log Out",style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 15,color: AppTheme().getHeaderColor())))
            ),
            TextButton(
                onPressed: (){
                  Navigator.pop(context,false);
                },
                child: Text("Cancel",style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)))
            )
          ],
        ));
    if(willLogOut == true){
      Provider.of<SearchBoxModel>(context,listen: false).reset();
      secureStorage.delete(key: "accountToken");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogIn()),(route)=>false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(175, 204, 255, 0.35),
        title: Text("Settings",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontWeight: FontWeight.bold,fontSize: 30)),),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(top: MediaQuery.of(context).size.width/10),
              child: Container(
                width: MediaQuery.of(context).size.width/1.15,
                height: MediaQuery.of(context).size.height/9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: AppTheme().getColor(),blurRadius: 2.8),
                      BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.55),blurRadius: 0.8),
                    ]
                ),
                child: Row(
                  spacing: 10.0,
                  children: [
                    IconButton(
                        onPressed: (){
                          _confirmLogOut(context);
                        },
                        icon: Icon(Icons.logout,color: AppTheme().getIconColor(),size: 30,)
                    ),
                    Text("Log Out",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontSize: 20)),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}