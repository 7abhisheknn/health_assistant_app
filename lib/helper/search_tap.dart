import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future searchOnTap(Map<String, dynamic> doctor) async {
  final doc = await FirebaseFirestore.instance.collection('all_chats').add({});
  final docId = doc.id;
  final id = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot? patient;
  await FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .get()
      .then((value) {
    patient = value;
  });
  final newChatId = doctor['doc_id'] + patient!['doc_id'];
  await FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('my_chats')
      .doc(newChatId)
      .set({
    'chat_id': docId,
    'username': doctor['username'],
    'image_url': doctor['image_url'],
  });

  await FirebaseFirestore.instance
      .collection('user')
      .doc(doctor['doc_id'])
      .collection('my_chats')
      .doc(newChatId)
      .set({
    'chat_id': docId,
    'username': patient!['username'],
    'image_url': patient!['image_url'],
    'doc_id': patient!['doc_id'],
  });
}
