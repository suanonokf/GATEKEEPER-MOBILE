import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:namer_app/Service/AppTheme.dart';

class StudentService extends StatefulWidget{
  String studentId;
  StudentService(this.studentId);

  @override
  State<StudentService> createState() => _StudentServiceState();
}

class _StudentServiceState extends State<StudentService> {
  late Future<String> studentInfo;
  @override
  void initState(){
    super.initState();
    studentInfo=searchStudentInfo();
  }
   Future<String> searchStudentInfo()async{
    String body="";
    Map<String,String>payload={
      "id": widget.studentId,
    };
    try{
      var response = await http.get(
        Uri.parse("http://localhost:8080/roles/1"),
      );
      if(response.statusCode==200){
         body= response.body;
      }
    }
    catch(error){
      return "Error: $error";
    }
    return body;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height/3,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height/5
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.white, spreadRadius: 3,)
        ],
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: FutureBuilder(
        future: studentInfo,
        builder: (context, asyncSnapshot) {
          if(asyncSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(asyncSnapshot.connectionState == ConnectionState.none){
            return Center(child: Text("An Error Occurred",style: GoogleFonts.notoSans(textStyle: TextStyle(color: Colors.redAccent)),),);
          }
          else{
            return Column(
              children: [
                Text(asyncSnapshot.requireData)
              ],
            );
          }
        }
      ),
    );
  }
}