import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn _googleSignIn = GoogleSignIn();
Future<void> handleGoogleSignIn() async{
  try{
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if(account==null){
      return;
    }
    GoogleSignInAuthentication authentication = await account.authentication;
    final String? accessToken = authentication.accessToken;
    final String? idToken = authentication.idToken;
    // print("Access Token: $accessToken");
    // print("Id Token: $idToken");
     final response  = http.post(
       Uri.parse("backend api"),
       headers: {
         'Content-Type':'Application/json',
         'Authorization':'Bearer $accessToken'
       },
     );
     if(response==200){
       print("Success");
     }
  }
  catch(error){
    print("An error occurred");
  }
}