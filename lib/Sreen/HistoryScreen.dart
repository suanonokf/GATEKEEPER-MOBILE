import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Sreen/Home.dart';
import 'package:provider/provider.dart';

import '../Service/AppTheme.dart' show AppTheme;

class HistoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return HistoryFrame();
  }
}

class HistoryFrame extends StatelessWidget {
  List<String> history=[];
  @override
  Widget build(BuildContext context) {
     history = context.watch<SearchBoxModel>().getHistory();
     bool empty;
     if(history.isEmpty){
       empty=true;
     }
     else{
       empty=false;
     }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(175, 204, 255, 0.35),
        automaticallyImplyLeading: false,
        title: Text("Search History",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontWeight: FontWeight.bold,fontSize: 30)),),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: empty?Center(
      child:Container(
        width: MediaQuery.of(context).size.width/1.5,
        height: MediaQuery.of(context).size.height/6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: AppTheme().getColor(),blurRadius: 2.8),
              BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.55),blurRadius: 0.8),
            ]
        ),
        child: Center(child: Text("No History Search",style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: FontWeight.bold)),),),
      ),
    ):ListView.builder(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width/10),
        itemCount: history.length,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsetsGeometry.only(top: 10),
            child: Container(
              width: MediaQuery.of(context).size.width/4,
              height: MediaQuery.of(context).size.height/6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: AppTheme().getColor(),blurRadius: 2.8),
                    BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.55),blurRadius: 0.8),
                  ]
              ),
              child: Center(child: Text("ID: ${history[index]}",style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: FontWeight.bold)),),),
            ),
          );
        },
      ),
    );
  }
}