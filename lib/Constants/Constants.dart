import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

final tasksRef = _fireStore.collection('tasks');
