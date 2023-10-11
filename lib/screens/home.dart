import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/customWidgets/TodoItem.dart';
import 'package:todoapp/models/Task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // only for test ui
  // final tasks = Task.generateTasks();
  List<Task> tasks = [];
  final _textController = TextEditingController();
  bool _filterByDone = true;
  bool _checked = false;

  void _addToDoItem(String info) {
    setState(() {
      tasks.add(Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          info: info,
          isDone: _checked));
    });
    _textController.clear();
    _checked = false;
  }

  void _changeTaskStatus(Task todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTask(Task todo) {
    setState(() {
      tasks.removeWhere((item) => item.id == todo.id);
    });
  }

  void _filter() {
    List<Task> results = [];
    for (Task task in tasks) {
      if (task.isDone == _filterByDone) {
        results.add(task);
      }
    }
    for (Task task in tasks) {
      if (task.isDone != _filterByDone) {
        results.add(task);
      }
    }
    setState(() {
      tasks = results;
      _filterByDone = !this._filterByDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Tasks: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: Text(
                            _filterByDone
                                ? 'filter by done'
                                : 'filter by undone',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            _filter();
                          },
                        ),
                      ],
                    ),
                  ),
                  for (Task task in tasks)
                    TodoItem(
                      task: task,
                      changeTaskStatus: _changeTaskStatus,
                      deleteTask: _deleteTask,
                    )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            hintText: "add something to do...",
                            border: InputBorder.none),
                      ),
                    ),
                    Checkbox(
                        value: _checked,
                        onChanged: (value) {
                          setState(() {
                            _checked = !_checked;
                          });
                        }),
                    Container(
                      child: ElevatedButton(
                        child: Text(
                          '+',
                          style: TextStyle(
                              fontSize: 20, color: Colors.amberAccent),
                        ),
                        onPressed: () {
                          _addToDoItem(_textController.text);
                        },
                      ),
                    )
                  ])),
            )
          ],
        ));
  }
}
