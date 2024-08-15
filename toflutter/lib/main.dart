import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final String task = _taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task);
      });
      _taskController.clear();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index] = _tasks[index].startsWith('✔️ ') ? _tasks[index].substring(2) : '✔️ ' + _tasks[index];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                child: TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a task',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  onTap: () => _toggleTaskCompletion(index),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
