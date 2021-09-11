import 'package:flutter/material.dart';
import 'package:todofirebase/models/TasksData.dart';

import '../models/Task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final TasksData tasksData;

  const TaskTile({Key key, @required this.task, @required this.tasksData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.blue,
          value: task.isFinished,
          onChanged: (checkbox) {
            tasksData.updateTask(task);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isFinished
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            tasksData.deleteTask(task);
          },
        ),
      ),
    );
  }
}
