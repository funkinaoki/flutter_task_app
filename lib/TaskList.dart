import './main.dart';
import './TaskView.dart';
import 'package:flutter/material.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key, this.task}) : super(key: key);
  final Task? task;
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late TextEditingController _controller;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FavoriteView(
                  favoriteTasks: tasks
                      .where((element) => element.favorite == true)
                      .toList(),
                ),
              ),
            );
          },
          icon: const Icon(Icons.star),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "タスク入力",
                      hintText: "タスク入力",
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 20.0, bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => tasks.add(Task(title: _controller.text)));
                  },
                  child: const Text('保存'),
                ),
              )
            ],
          ),
          ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: tasks.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, int index) {
              return ListTile(
                title: Text(tasks[index].title),
                leading: IconButton(
                  icon: tasks[index].favorite
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                  onPressed: () {
                    setState(
                        () => tasks[index].favorite = !tasks[index].favorite);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    List<Task> result = await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("確認"),
                          content: const Text("本当に削除しますか。"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(tasks),
                              child: const Text("キャンセル"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(tasks[index].title);
                                tasks.removeAt(index);
                                Navigator.of(context).pop(tasks);
                              },
                              child: const Text("削除"),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() => tasks = result);
                  },
                ),
                subtitle: const Text("subtitle"),
                onTap: () async {
                  Task result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskView(task: tasks[index]),
                    ),
                  );
                  setState(() => tasks[index] = result);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
