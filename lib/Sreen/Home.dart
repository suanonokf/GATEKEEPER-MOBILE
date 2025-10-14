import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Service/AppTheme.dart';
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
    // DateTime selectDate = DateTime.now();
    // void pickedDate() async{
    //   DateTime? picked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    //   if(picked!=null && picked!= selectDate){
    //     selectDate=picked;
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().getColor(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontWeight: FontWeight.bold,fontSize: 37)),),
          ],
        )
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth/10, 0, screenWidth/10, screenWidth/5),
                  child: Text("What are we \ndoing today ?",style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: (){
                      // Pop up for creating a tasks
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.black,
                    child: Icon(Icons.add,size: 30,),
                  ),
                ),
                SizedBox(height: screenHeight/20,),
                TaskView()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth/10, 0, screenWidth/10, screenHeight/30),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppTheme().getColor()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: (screenWidth/3)-60,
            children: [
              IconButton(
                onPressed:(){
                  //route to home screen
                },
                icon: Icon(Icons.home_filled,color: AppTheme().getIconColor(),size: 40,),
              ),
              IconButton(
                onPressed:(){
                  //route to tasks screen
                },
                icon: Icon(Icons.task,color: AppTheme().getIconColor(),size: 40,),
              ),
              IconButton(
                onPressed:(){
                  // route to setting screen
                },
                icon: Icon(Icons.settings,color: AppTheme().getIconColor(),size: 40,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TaskViewState();
}
class TaskViewState extends State<TaskView>{
  @override
  Widget build(BuildContext context) {
    List<dynamic> tasksList =["Orange","Apple","Banana","","","","",""];
    NewTasks tasks = NewTasks(tasksList);
    return  ListView.builder(
        shrinkWrap: true,
        itemCount: tasksList.length,
          itemBuilder: (context,int index){
          return Card(
            color: Color.fromRGBO(199, 214, 242, 1),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:EdgeInsets.all(10),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(77, 85, 204, 0.5),
                        borderRadius: BorderRadius.circular(25)
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                Column(
                  children: [
                    Text("${tasksList[index]}",style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.black,fontSize: 18)),),
                  ],
                )
              ],
            ),
          );
          }
      );
  }

}