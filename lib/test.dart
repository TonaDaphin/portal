import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference requests =
    FirebaseFirestore.instance.collection('request');


final docRef = requests.doc('requests');

///[addTask] add new task in the task manager
Future<void> addRequest({
  required String category,
  required String faculty,
  required String title,
  required String description,
  required String sender,
}) {
  return requests.add({
    'category': category,
    'faculty': faculty,
    'title': title,
    'description': description,
    'sender': sender
  });
}

Future<DocumentSnapshot> retrieveRequestById(String requestId) {
  return requests.doc(requestId).get();
}

Future<QuerySnapshot> retrieveRepliesByRequestId(String requestId) {
  return FirebaseFirestore.instance
      .collection('requests') // Reference the top-level collection
      .doc(requestId) // Reference the specific request document
      .collection('replies') // Reference the subcollection "replies"
      .get(); // Retrieve the documents from the "replies" subcollection
}

Future<void> addReplyToRequest({
  required String requestId,
  required String sender,
  required String reply,
  required Timestamp timestamp,
}) {
  return FirebaseFirestore.instance
      .collection('request')
      .doc(requestId)
      .collection('replies')
      .add({'sender': sender, 'reply': reply, 'timestamp': timestamp});
}
