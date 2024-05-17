import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpWithEmailAndPassword(String email, String uid) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'createdAt': Timestamp.now(),
        'robotCount': 0,
      });
      print('User data written to Firestore');
    } catch (e) {
      print('Error writing user data to Firestore: $e');
      throw e;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (!userDoc.exists) {
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'createdAt': Timestamp.now(),
            'robotCount': 0,
          });
        }
        print('Google user data processed');
      }
    } catch (e) {
      print('Error processing Google user data: $e');
      throw e;
    }
  }

  Future<void> addRobot(String host, String apiKeyId, String apiKey) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference robotRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('robots')
          .doc('robot');

      await robotRef.set({
        'host': host,
        'apiKeyId': apiKeyId,
        'apiKey': apiKey,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('Robot data added to Firestore for user ${user.uid}');
    } else {
      print('No authenticated user found');
    }
  }

}
