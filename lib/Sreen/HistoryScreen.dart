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
  var history=[];
  @override
  Widget build(BuildContext context) {
    history = Provider.of<SearchBoxModel>(context, listen: false).getHistory();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(175, 204, 255, 0.35),
        leading: BackButton(
          color: AppTheme().getIconColor(),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Search History",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontWeight: FontWeight.bold,fontSize: 30)),),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: ListView.builder(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width/5),
        itemCount: history.length,
        itemBuilder: (context,index){
          return Container(
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
          );
      },
        ),
      );
  }
}