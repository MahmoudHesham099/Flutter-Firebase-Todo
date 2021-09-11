import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constants/Constants.dart';
import '../models/Task.dart';

class DatabaseServices {
  static void createTask(Task task) {
    // tasksRef from constants file
    // create document in 'tasks' collection
    // make document id equal to task id
    tasksRef.doc(task.id).set({
      'title': task.title,
      'isFinished': task.isFinished,
      "timestamp": task.timestamp,
    });
  }

  static void updateTask(Task task) {
    // update task status (isFinished)
    tasksRef.doc(task.id).update({
      'isFinished': task.isFinished,
    });
  }

  static void deleteTask(Task task) {
    // delete task document
    tasksRef.doc(task.id).delete();
  }

  static Future<List> getTasks() async {
    // get tasks documents in firebase ordered by timestamp (create time)
    QuerySnapshot tasksSnapshot = await tasksRef.orderBy('timestamp').get();
    // change from docs list to Tasks objects list
    List<Task> tasks =
        tasksSnapshot.docs.map((doc) => Task.fromDoc(doc)).toList();
    return tasks;
  }
}
