import 'package:flutter/material.dart';
import 'package:sqflite_learn/main.dart';
import 'package:sqflite_learn/sqldb.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.title, required this.note,required this.id});

  final String note;

  final String title;
  final id ;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;

    super.initState();
  }

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
                            int response = await sqlDb.updateData('''
                            UPDATE notes SET 
                            note = "${note.text}",
                            title="${title.text}"
                            WHERE id = ${widget.id}
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
                          child: Text('edit note'),
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
