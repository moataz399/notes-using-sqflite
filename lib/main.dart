import 'package:flutter/material.dart';
import 'package:sqflite_learn/add_notes_screen.dart';
import 'package:sqflite_learn/sqldb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {"addNotesScreen": (context) => AddNotesScreen()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqlDb sqlDb = SqlDb();
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("notes "),
      ),
      body: Container(
        child: ListView(
          children: [
            ListView.builder(
                itemCount: notes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      subtitle: Text("${notes[index]["note"]}"),
                      title: Text("${notes[index]["title"]}"),
                      trailing: IconButton(
                          onPressed: () async {
                            int response = await sqlDb.deleteData(
                                "DELETE FROM notes WHERE id=${notes[index]["id"]} ");
                            if (response > 0) {
                              notes.removeWhere((element) =>
                                  element["id"] == notes[index]["id"]);
                              print('deleted ====================$response');
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNotesScreen");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
