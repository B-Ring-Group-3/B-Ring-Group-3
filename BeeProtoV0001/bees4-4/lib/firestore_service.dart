import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addRobotTemp(String uid, double temperature) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('robots')
        .doc('robot')
        .set({
      'temperature': temperature,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // Use merge to avoid overwriting existing data
  }

  Stream<double?> getRobotTemp(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('robots')
        .doc('robot')
        .snapshots()
        .map((snapshot) => snapshot.data()?['temperature'] as double?);
  }

}