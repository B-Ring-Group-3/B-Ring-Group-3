import 'package:bees4/core/app_export.dart';
import 'package:bees4/main.dart';
import 'package:bees4/widgets/custom_outlined_button.dart';
import 'package:bees4/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:bees4/auth_service.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to Bee Ring! Please sign in to continue.'
                        : 'Welcome to Bee Ring! Please create an account to continue',
                  ),
                );
              },
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomImageView(
                        imagePath: ImageConstant.imgBeeRingLogo,
                        height: 120.v,
                        width: 120.h,
                        alignment: Alignment.center,
                        //margin: EdgeInsets.only(left: 91.h)
                    )
                  ),
                );
              },
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId: '210411111773-eajqijf8n77q4ndmu2c7goiehv2nkolj.apps.googleusercontent.com',
                )
              ],

          );
        }
        else{
          final User? user = snapshot.data;
          if (user != null) {
            final AuthService authService = AuthService();
            print('User signed in: ${user.uid}');
            if (user.metadata.creationTime == user.metadata.lastSignInTime) {
              authService.signUpWithEmailAndPassword(user.email!, user.uid).then((_) {
                print('New user data written to Firestore');
              }).catchError((error) {
                print('Error writing new user data to Firestore: $error');
              });
            } else {
              authService.signInWithGoogle().then((_) {
                print('Existing user data processed');
              }).catchError((error) {
                print('Error processing existing user data: $error');
              });
            }
          }
          Future.microtask(() =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.bRingDashScreen));
          // Return a placeholder widget to satisfy the builder function.
          // This widget is temporary and won't be visible to the user due to the navigation.
          return Container();
        }

        // Render your application if authenticated
        return MyApp();
      },
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}