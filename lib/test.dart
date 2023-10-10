import 'package:cloud_firestore/cloud_firestore.dart';

///[tasks] holds tasks collection from database
final CollectionReference tasks =
    FirebaseFirestore.instance.collection('test');

///[addTask] add new task in the task manager
Future<void> addTask({
  required String name,
 
}) {
  return tasks.add({
    'name': name,
  

    // 'timestamp': FieldValue.serverTimestamp(),
  });
}
