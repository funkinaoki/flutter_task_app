import 'package:flutter/material.dart';
import './main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TaskView extends StatefulWidget {
  final Task task;

  const TaskView({Key? key, required this.task}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(
          widget.task,
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: pushEditView(context),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.task.title),
              widget.task.favorite
                  ? const Icon(Icons.star)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        body: Column(
          children: [
            const Text('title'),
            Text(widget.task.title),
            const Text('subtitle'),
            (widget.task.subTitle != null)
                ? Text(widget.task.subTitle!)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  List<Widget> pushEditView(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "タイトル",
                            hintText: widget.task.title.toString(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                widget.task.title = _controller.text;
                                Navigator.of(context).pop(widget.task);
                              },
                            );
                          },
                          child: const Text("保存"),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.edit)),
    ];
  }
}
