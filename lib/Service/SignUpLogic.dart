import 'dart:convert';

import 'package:http/http.dart' as http;

class signUpLogic {
    String firstName;
    String lastName;
    String email;
    String password;
    String confirmedPassword;

    signUpLogic(this.firstName,this.lastName,this.email,this.password,this.confirmedPassword);

    Future<String> submit() async{
      Map<String,String> payload={
        "nom_complet": this.firstName+this.lastName,
        "email": this.email,
        "date_naissance": "01-04-2005",
        "password": this.password,
        "password_confirmation": this.confirmedPassword

      };
      try{
        final response = await http.post(
          Uri.parse('http://localhost:8080/users'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        );
        if(response.statusCode==200 || response.statusCode==201){
          print(response.statusCode);
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