import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Service/SignUpLogic.dart';
import 'package:provider/provider.dart';

class SignUpFrame extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> FrameState(),
      child: MaterialApp(
        home: SignUpWidget(),
        theme: ThemeData(colorSchemeSeed: AppTheme().getColor()),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
class FrameState extends ChangeNotifier{
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _fNameTextController = TextEditingController();
  final _lNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmedPasswordTextController = TextEditingController();
}

class SignUpWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<FrameState>();
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignUpForm()
          ],
        ),
      ),
    );
  }
}
class SignUpForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final paddingSize = height/20;

    var appState = context.watch<FrameState>();
    var formKey = appState._formKey;
    var textController = appState._emailTextController;
    var fNameTextController = appState._fNameTextController;
    var lNameTextController = appState._lNameTextController;
    var passwordTextController = appState._passwordTextController;
    var confirmedPasswordTextController = appState._confirmedPasswordTextController;
    return Padding(
      padding:  EdgeInsets.all(paddingSize),
      child: Form(
        key: formKey,
          child: Column(
            children: [
              Text("Sign Up",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(), fontSize: 32,fontWeight: FontWeight.bold),)),
              SizedBox(height: paddingSize,),
              TextFormField(
                controller: fNameTextController,
                validator: (value){
                  if(value==null){
                    return "Enter your FirstName";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text("FirstName",style: TextStyle(color: Colors.black,fontSize: 18),),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    )
                ),
              ),
              SizedBox(height: paddingSize/5,),
              TextFormField(
                controller: lNameTextController,
                validator: (value){
                  if(value==null){
                    return "Enter your LastName";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text("LastName",style: TextStyle(color: Colors.black,fontSize: 18),),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    )
                ),
              ),
              SizedBox(height: paddingSize/5,),
              TextFormField(
                controller: textController,
                validator: (value){
                  if(value==null||!value.contains("@gmail.com")){
                    return "Invalid Email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text("Email",style: TextStyle(color: Colors.black,fontSize: 18),),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    )
                ),
              ),
              SizedBox(height: paddingSize/5,),
              TextFormField(
                controller: passwordTextController,
                validator: (value){
                  if(value==null){
                    return "Enter your First Name";
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
                    label: Text("Password",style: TextStyle(color: Colors.black,fontSize: 18),),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    )
                ),
              ),
              SizedBox(height: paddingSize/5,),
              TextFormField(
                controller: confirmedPasswordTextController,
                validator: (value){
                  if(value==null){
                    return "Confirmed your password";
                  }
                  if(passwordTextController.text!=confirmedPasswordTextController.text){
                    return "Confirmed your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text("Confirmed Password",style: TextStyle(color: Colors.black,fontSize: 18),),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    )
                ),
              ),
              SizedBox(height: paddingSize,),
              ElevatedButton(
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      var fName = fNameTextController.text.trim();
                      var lName = lNameTextController.text.trim();
                      var email = textController.text.trim();
                      var password = passwordTextController.text.trim();
                      var confirmedPassword = confirmedPasswordTextController.text.trim();
                      signUpLogic signUp = signUpLogic(fName,lName,email,password,confirmedPassword);
                      String valid = await signUp.submit();
                      if(valid=="Submitted"){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Valid !")));
                      }
                    }
                  },
                  child: Text("Submit",style:TextStyle(color: Colors.black87,fontSize: 20)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              )
            ],
          )
      ),
    );
  }

}