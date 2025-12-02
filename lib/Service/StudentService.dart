import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  FlutterSecureStorage secureStorage = new FlutterSecureStorage();
  @override
  void initState(){
    super.initState();
    studentInfo=searchStudentInfo();
  }
   Future<String> searchStudentInfo()async{
    String body="";
    final token = await secureStorage.read(key: 'accountToken');
    Map<String,String>payload={
      "student_id": widget.studentId,
    };
    try{
      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/gatekeeper/verify/id"),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body: jsonEncode(payload)
      );
      if(response.statusCode==200 || response.statusCode==201){
         body= response.body;
      }
      else if(response.statusCode==404){
        return "Student Not Found";
      }
      else{
        return "Status: ${response.statusCode}";
      }
    }
    catch(error){
      return "Error: $error";
    }
    if(body.isEmpty) return "Empty Response";
    var result = jsonDecode(body);
    return " ID: ${result['data']['student_id']} \n"
        " Name: ${result['data']['name']} \n "
        "Email: ${result['data']['email']}";
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(asyncSnapshot.requireData,style: GoogleFonts.notoSans(fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            );
          }
        }
      ),
    );
  }
}