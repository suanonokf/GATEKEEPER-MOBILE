import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Service/QRScanner.dart';
import 'package:namer_app/Service/StudentService.dart';


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
              QRScanner(),
              SizedBox(height: 30,),
              SearchBox(),
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
                icon: Icon(CupertinoIcons.house_fill,color: AppTheme().getIconColor(),size: 40,),
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
                icon: Icon(CupertinoIcons.settings,color: AppTheme().getIconColor(),size: 40,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatefulWidget{
  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String id="";
  @override
  Widget build(BuildContext context) {
    final idTextController = TextEditingController();

    final height = MediaQuery.of(context).size.height/2;
    final width =  MediaQuery.of(context).size.width/2;
    final  key = GlobalKey<FormState>();
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
      ),
     decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20),
       boxShadow: [
         BoxShadow(color: AppTheme().getColor(),blurRadius: 2.8),
         BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.55),blurRadius: 0.8),
       ]
     ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: height/10),
              child: Text("Search Student Info", style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontSize: 25,fontWeight: FontWeight.bold)),),
            ),
            SizedBox(height: height/20,),
            Form(
                key: key,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(width/9,0,width/4,0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: idTextController,
                        validator: (value){
                          if (value == null || value.trim().isEmpty) {
                            return "Enter ID";
                          }
                          final parsed = num.tryParse(value);
                          if (parsed == null) {
                            return "Invalid ID";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: CupertinoColors.white,
                          icon: Icon(CupertinoIcons.search),
                          label: Text("Search",style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 15)),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white54)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white54)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: height/20,),
                    ElevatedButton(
                      onPressed: (){
                        if(key.currentState!.validate()){
                          setState(() {
                            id = idTextController.text;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Valid !")));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme().getColor(),
                          fixedSize: Size(height/1.7, width/5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                      ),
                      child: Text("Search",style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: FontWeight.bold,color: AppTheme().getHeaderColor(),fontSize: 17)),),
                    ),

                    if(id.isNotEmpty)
                      Padding(
                        padding:  EdgeInsets.only(top: height/10),
                        child: StudentService(id),
                      )
                  ],
                ),
              ),
          ],
        ),
    );
  }
}
