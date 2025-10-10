import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 80, 40),
            child: Text("What are we doing today ?",style: GoogleFonts.oldenburg(textStyle: TextStyle(color: Color.fromRGBO(60, 79, 122, 0.9), fontSize: 30, fontWeight: FontWeight.bold)),),
          ),
            Center(
              child: FloatingActionButton(
                  onPressed: (){

                  },
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                child: Icon(Icons.adb_rounded),
              ),
            ),
            Expanded(flex: 0,child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TaskView(),
            ),),
          ],
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
    List<dynamic> tasksList =["Orange","Apple","Banana"];
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
                    Text("${tasksList[index]}",style: GoogleFonts.arima(textStyle: TextStyle(color: Colors.black,fontSize: 18)),),
                  ],
                )
              ],
            ),
          );
          }
      );
  }

}