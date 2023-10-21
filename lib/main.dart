import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do lista',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'To Do lista'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todoItems = [];
  final textController = TextEditingController();

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingresar Texto'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Escribe tu tarea',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String text = textController.text;
                  if (text.isNotEmpty) {
                    todoItems.add(TodoItem(text, false));
                  }
                  textController.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _removeItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              _removeItem(index);
            },
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: CheckboxListTile(
                title: Text(todoItems[index].text),
                value: todoItems[index].completed,
                onChanged: (bool? value) {
                  setState(() {
                    todoItems[index].completed = value!;
                  });
                },
                secondary: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _removeItem(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInputDialog();
        },
        tooltip: 'Ingresar Tarea',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  final String text;
  bool completed;
  TodoItem(this.text, this.completed);
}
