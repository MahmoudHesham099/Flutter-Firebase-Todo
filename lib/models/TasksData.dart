import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todofirebase/DatabaseServices/Database_Services.dart';
import 'package:todofirebase/models/Task.dart';
import 'package:uuid/uuid.dart';

class TasksData extends ChangeNotifier {
  List<Task> tasks = []; // Tasks List
  var uuid = Uuid(); // Id generator

  void addTask(String taskTitle) {
    String taskId = uuid.v4(); // generate unique id for the task
    Timestamp taskTimestamp =
        Timestamp.fromDate(DateTime.now()); // the time task was created
    Task task = Task(
        id: taskId, title: taskTitle, timestamp: taskTimestamp); // Task Object
    tasks.add(task); // add created task to the tasks list
    DatabaseServices.createTask(task); // add the created task to firebase
    notifyListeners(); // notify that tasks list is changed
  }

  void updateTask(Task task) {
    task.toggle(); // task checkbox is clicked
    DatabaseServices.updateTask(task); // update task status (isFinished)
    notifyListeners(); // notify task isFinished changed
  }

  void deleteTask(Task task) {
    tasks.remove(task); // remove task from tasks list
    DatabaseServices.deleteTask(task); // delete the task from firebase
    notifyListeners(); // notify that tasks list is changed
  }
}
