import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Task {
  final String id; // each task has unique id
  final String title; // each task has title
  final Timestamp timestamp; // time when task was created
  bool
      isFinished; // status of the task (at the first it will not be finished so = false)

  // required parameters
  Task(
      {@required this.id,
      @required this.title,
      @required this.timestamp,
      this.isFinished = false});

  // change task from doc to Task object
  factory Task.fromDoc(DocumentSnapshot doc) {
    return Task(
        id: doc.id,
        title: doc['title'],
        isFinished: doc['isFinished'],
        timestamp: doc['timestamp']);
  }

  // when task checkbox is clicked
  void toggle() {
    isFinished = !isFinished;
  }
}
