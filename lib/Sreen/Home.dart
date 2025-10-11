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
    // DateTime selectDate = DateTime.now();
    // void pickedDate() async{
    //   DateTime? picked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    //   if(picked!=null && picked!= selectDate){
    //     selectDate=picked;
    //   }
    // }
    String formattedDate = DateFormat('E-MMM d-yyyy').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().getColor(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text("Home",style: GoogleFonts.oldenburg(textStyle: TextStyle(color: Color.fromRGBO(60, 79, 122, 0.9),fontWeight: FontWeight.bold)),),
            Icon(Icons.calendar_month_outlined,color: Color.fromRGBO(60, 79, 122, 0.9),),
            Text("$formattedDate",style: GoogleFonts.nobile(textStyle: TextStyle(color: Color.fromRGBO(60, 79, 122, 0.9),fontWeight: FontWeight.bold)),),
          ],
        )
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 80, 40),
            child: Text("What are we doing today ?",style: GoogleFonts.oldenburg(textStyle: TextStyle(color: Color.fromRGBO(60, 79, 122, 0.9), fontSize: 30, fontWeight: FontWeight.bold)),),
          ),
            Center(
              child: FloatingActionButton(
                  onPressed: (){
                    // Pop up for creating a tasks
                  },
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(height: 120,),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: AppTheme().getColor(),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                    child: TaskView()
                ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(199, 214, 242, 0.53)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50,
                  children: [
                    IconButton(
                        onPressed:(){

                        },
                        icon: Icon(Icons.home_filled,color: Color.fromRGBO(60, 79, 122, 0.9),size: 40,),
                    ),
                    IconButton(
                      onPressed:(){

                      },
                      icon: Icon(Icons.task,color: Color.fromRGBO(60, 79, 122, 0.9),size: 40,),
                    ),
                    IconButton(
                      onPressed:(){

                      },
                      icon: Icon(Icons.settings,color: Color.fromRGBO(60, 79, 122, 0.9),size: 40,),
                    ),
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

class TaskView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TaskViewState();
}
class TaskViewState extends State<TaskView>{
  @override
  Widget build(BuildContext context) {
    List<dynamic> tasksList =["Orange","Apple","Banana","",""];
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