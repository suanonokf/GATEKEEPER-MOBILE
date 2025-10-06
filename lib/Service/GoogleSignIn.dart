import 'package:google_sign_in/google_sign_in.dart';

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
    print("Access Token: $accessToken");
    print("Id Token: $idToken");
  }
  catch(error){
    print("An error occurred");
  }
}