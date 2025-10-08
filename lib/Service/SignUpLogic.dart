import 'dart:convert';

import 'package:http/http.dart' as http;

class signUpLogic {
    String firstName;
    String lastName;
    String email;
    String password;

    signUpLogic(this.firstName,this.lastName,this.email,this.password);

    Future<String> submit() async{
      Map<String,String> payload={
        "firstName": this.firstName,
        "lastName": this.lastName,
        "email": this.email,
        "password": this.password
      };
      try{
        final response = await http.post(
          Uri.parse('https://your-backend-api.com/api/signup'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        );
        if(response.statusCode==200 || response.statusCode==201){
          return "Submitted";
        }
        else{
          return "Failed";
        }
      }
      catch(error){
        return "error: $error";
      }
    }
}