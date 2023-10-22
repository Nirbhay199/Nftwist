import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

Future<void> google(context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(   scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],);
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    // setState(() {
    //   loading=true;
    // });
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await FirebaseAuth.instance.signInWithCredential(authCredential);
    User? user = result.user;
    print(user!.email.toString(),);
    print(user.displayName,);
    print(googleSignInAccount.id);
    Provider.of<Auth>(context,listen: false).socialLogin(context,email: user.email.toString(),name:user.displayName,socialToken: googleSignInAccount.id,socialType: "GOOGLE",fcmtoken: "fcm" );
    // socialLogin(context,user.email.toString(),user.displayName,googleSignInAccount.id,"Google");
  }
}
Future<void> faceBook(context) async {
  final fb = FacebookAuth.instance;
  // print("---------------");
  // setState(() {
  //   loading = true;
  // });
  final res = await fb.login(permissions: ['email', 'public_profile']);
  switch (res.status) {
    case LoginStatus.success:
      final AccessToken? accessToken = res.accessToken;
      print('Access token: ${accessToken!.token}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}'));
      var profile = json.decode(graphResponse.body);
      String? email = profile["email"];
      Provider.of<Auth>(context,listen: false).socialLogin(context,email: email.toString(),name:profile['name'],socialToken: profile['id'],socialType: "FACEBOOK",fcmtoken: "fcm" );
      break;
    case LoginStatus.cancelled:
    // TODO: Handle this case.

      break;
    case LoginStatus.failed:
    // TODO: Handle this case.
      break;
    case LoginStatus.operationInProgress:
    // TODO: Handle this case.
      break;
  }
}


