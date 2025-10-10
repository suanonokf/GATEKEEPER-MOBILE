import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Service/GoogleSignIn.dart';

class LogIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogInPage(),
      theme: ThemeData(colorSchemeSeed: AppTheme().getColor()),
      debugShowCheckedModeBanner: false,
    );
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text("Log In",style: GoogleFonts.pacifico(textStyle: TextStyle(fontStyle: FontStyle.italic,fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black)),),
            SizedBox(height: 24,),
            Form(
              key: _formKey,
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    iconColor: Colors.black,
                    label:Text("Email",style: TextStyle(color: Colors.black,fontSize: 22),),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _anotherTextController,
                      validator: (value){
                        if(value==null){
                          return "Please enter your password";
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
                      iconColor: Colors.black,
                      label:Text("Password",style: TextStyle(color: Colors.black,fontSize: 22),),
                      fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10.0)
                        )
                  ),
                    style: TextStyle(fontSize: 20),
                  obscureText: true,),
                ),
                SizedBox(height: 40,),
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Valid !")));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Submit",style: TextStyle(color: Colors.black87,fontSize: 20),),
                    ),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text("Sign Up With:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      IconButton(
                          onPressed: handleGoogleSignIn,
                          icon: Image.asset("assets/google_icon.png"),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

}
