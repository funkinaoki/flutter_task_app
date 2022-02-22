import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './TaskList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskListView(),
    );
  }
}

class Task {
  String title;
  String? subTitle;
  bool favorite;

  Task({required this.title, this.subTitle, this.favorite = false});
}

class FavoriteView extends StatelessWidget {
  final List<Task> favoriteTasks;
  const FavoriteView({Key? key, required this.favoriteTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('お気に入り'),
      ),
      body: ListView.builder(
        itemCount: favoriteTasks.length,
        itemBuilder: (_, int index) {
          return ListTile(
            title: Text(favoriteTasks[index].title),
          );
        },
      ),
    );
  }
}
