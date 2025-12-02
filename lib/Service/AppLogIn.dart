import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AppLogIn{
  String _email;
  String _password;
  AppLogIn(this._email,this._password);
  Future<String> getAccount() async{
    var responseBody;
    Map<String,String>payload={
      "email":this._email,
      "password": this._password
    };
    try{
      final response= await http.post(
        Uri.parse("http://10.0.2.2:8000/api/auth/gatekeeper/login"),
        headers: {'Content-Type':'application/json'},
        body: jsonEncode(payload)
      );
      if(response.statusCode==201 || response.statusCode==200){
        responseBody = jsonDecode(response.body);
        return responseBody['data']['token'];
      }
      else{
        return "Invalid";
      }
    }
    on SocketException{
      return "Socket Exception";
    }
    on FormatException{
      return "Format Exception";
    }
    on TimeoutException{
      return "TimeOut";
    }
    catch(error){
      return "Unexpected: $error";
    }
  }
}