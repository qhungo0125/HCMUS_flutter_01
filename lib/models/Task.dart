class Task {
  String? id;
  String? info;
  bool isDone;

  Task({required this.id, required this.info, this.isDone = false});

  static List<Task> generateTasks() {
    return [
      Task(id: "01", info: "task 1"),
      Task(id: "02", info: "task 2", isDone: true),
      Task(id: "03", info: "task 3", isDone: true),
      Task(id: "04", info: "task 4"),
    ];
  }
}
