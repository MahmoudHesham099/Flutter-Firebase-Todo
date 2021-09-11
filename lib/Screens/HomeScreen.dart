import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/DatabaseServices/Database_Services.dart';
import 'package:todofirebase/Widgets/TaskTile.dart';
import 'package:todofirebase/models/Task.dart';
import 'package:todofirebase/models/TasksData.dart';
import 'AddTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true; // loading when the app start

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback to wait and use context in initState()
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      List<Task> tasks =
          await DatabaseServices.getTasks(); // get tasks from firebase
      setState(() {
        // the provider tasks list = list came from firebase
        Provider.of<TasksData>(context, listen: false).tasks = tasks;
        _loading = false; // loading is over
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Todo Tasks (${Provider.of<TasksData>(context).tasks.length})',
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return AddTaskScreen();
                    });
              },
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<TasksData>(
                builder: (context, tasksData, child) {
                  return ListView.builder(
                    itemCount: tasksData.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasksData.tasks[index];
                      return TaskTile(
                        task: task,
                        tasksData: tasksData,
                      );
                    },
                  );
                },
              ),
            ),
          );
  }
}
