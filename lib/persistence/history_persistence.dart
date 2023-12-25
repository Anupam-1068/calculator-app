import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryPersistence {
  late FirebaseFirestore _firestore;

  Future<void> initDatabase() async {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> addToHistory(String calculation) async {
    await initDatabase();

    // Save to Firestore
    await _firestore.collection('calculator_history').add({
      'calculation': calculation,
      'timestamp': DateTime.now(),
    });
  }

  Future<List<String>> getHistory() async {
    await initDatabase();

    // Retrieve history from Firestore
    QuerySnapshot firestoreHistory = await _firestore.collection('calculator_history').get();
    List<String> cloudHistory = firestoreHistory.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return '${data['calculation']} - ${data['timestamp']}';
    }).toList();

    // Return the history from Firestore
    return cloudHistory;
  }

  // Method to clear history
  void clear() async {
    await initDatabase();

    // Clear history in Firestore
    QuerySnapshot firestoreHistory = await _firestore.collection('calculator_history').get();
    for (QueryDocumentSnapshot doc in firestoreHistory.docs) {
      await doc.reference.delete();
    }
  }
}
