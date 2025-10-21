import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Service/QrScanner.dart';
import 'package:namer_app/Service/TaskListController/NewTasks.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeFrame(),
      theme: ThemeData(colorSchemeSeed: AppTheme().getColor()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeFrame extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(175, 204, 255, 0.35),
        title:
            Text("Home",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontWeight: FontWeight.bold,fontSize: 30)),),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Padding(
        padding:  EdgeInsets.all(screenWidth/40),
        child: ListView(
            children: [
              QrScanner()
            ],
          ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth/20, 0, screenWidth/20, screenHeight/30),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(175, 204, 255, 0.35)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: (screenWidth/3)-60,
            children: [
              IconButton(
                onPressed:(){
                  //route to home screen
                },
                icon: Icon(Icons.home_rounded,color: AppTheme().getIconColor(),size: 40,),
              ),
              IconButton(
                onPressed:(){
                  //route to tasks screen
                },
                icon: Icon(Icons.history_sharp,color: AppTheme().getIconColor(),size: 40,),
              ),
              IconButton(
                onPressed:(){
                  // route to setting screen
                },
                icon: Icon(Icons.settings_outlined,color: AppTheme().getIconColor(),size: 40,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
