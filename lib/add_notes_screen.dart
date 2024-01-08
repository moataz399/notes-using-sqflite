import 'package:flutter/material.dart';
import 'package:sqflite_learn/main.dart';
import 'package:sqflite_learn/sqldb.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form(
                      child: Column(
                    children: [
                      TextField(
                        controller: title,
                        decoration: InputDecoration(hintText: "title"),
                      ),
                      TextField(
                        controller: note,
                        decoration: InputDecoration(hintText: "note"),
                      ),
                      Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () async {
                            int response = await sqlDb.insertData(
                                '''
                            INSERT INTO 'notes' (`note`,`title`)
                             VALUES ("${note.text}","${title.text}")
                     
                     ''');
                            print(response);
                            print("response=========================");
                            if (response > 0) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                  (route) => false);
                            }
                          },
                          child: Text('add note'),
                          textColor: Colors.white,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  )),
                ],
              ))),
    );
  }
}
