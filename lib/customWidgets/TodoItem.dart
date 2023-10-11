import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/models/Task.dart';

class TodoItem extends StatelessWidget {
  final Task task;
  final changeTaskStatus;
  final deleteTask;
  const TodoItem(
      {super.key,
      required this.task,
      required this.changeTaskStatus,
      required this.deleteTask});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: () {
            print("click on item");
            changeTaskStatus(task);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
            task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(
            task.info!,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: task.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                print("click on delete item");
                deleteTask(task);
              },
            ),
          ),
        ));
  }
}
