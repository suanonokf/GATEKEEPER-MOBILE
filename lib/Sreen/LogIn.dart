import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Service/AppLogIn.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Service/GoogleSignIn.dart';

class LogIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return LogInPage();
  }
}

class LogInPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyForm()
          ],
        ),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}

class MyForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyFormState();
}
class MyFormState extends State<MyForm>{
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _anotherTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingSize = screenWidth/20;
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Log In",style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: AppTheme().getHeaderColor())),),
            SizedBox(height: screenHeight/20,),
            Form(
              key: _formKey,
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(paddingSize, paddingSize/2, paddingSize, paddingSize/2),
                  child: TextFormField(
                    controller: _textController,
                    validator: (value){
                      if(value==null || !value.contains("@gmail.com")){
                        return "This Field Must Contain Your Gmail Address";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    iconColor: AppTheme().getIconColor(),
                    label:Text("Email",style: TextStyle(color: Colors.black,fontSize: 18),),
                    hintText: "****@gmail.com",
                    fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black12)
                      ),
                  ),
                  style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(paddingSize, paddingSize/2, paddingSize, paddingSize/2),
                  child: TextFormField(
                      controller: _anotherTextController,
                      validator: (value){
                        if(value!.length<=7){
                          return " Password must contain at least 8 characters";
                        }
                        final hasUpperCase = RegExp(r'[a-z]').hasMatch(value);
                        final hasLowerCase = RegExp(r"[A-Z]").hasMatch(value);
                        final hasSpecialCharater = RegExp(r"[!@#%$^&*(){}><.,;:]").hasMatch(value);
                        final hasNumber = RegExp(r"\d").hasMatch(value);
                        if(!hasUpperCase){
                          return "Must contain an upper case letter";
                        }
                        if(!hasLowerCase) return "Must contain a lower case letter";
                        if(!hasSpecialCharater) return "Must contain a special character";
                        if(!hasNumber) return "Must contain a number";
                        return null;
                      },
                      decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      iconColor: AppTheme().getIconColor(),
                      label:Text("Password",style: TextStyle(color: Colors.black,fontSize: 18),),
                      fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10.0)
                        )
                  ),
                   style: TextStyle(fontSize: 20),
                  obscureText: true,),
                ),
                SizedBox(height: screenHeight/30,),
                ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        var accountToken = await AppLogIn(_textController.text, _anotherTextController.text).getAccount();
                        if(accountToken!="Invalid"){
                          secureStorage.write(key: "accountToken", value: accountToken.toString());
                          // Use FlutterStorageSecure to store the token / create a splash screen ps: don't forget android and ios config
                          Navigator.pushNamed(context, '/Home');
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("InValid Credentials!")));
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Submit",style: TextStyle(color: Colors.black87,fontSize: 20),),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    )
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

}
