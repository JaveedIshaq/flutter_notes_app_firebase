import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter_notes_app/model/user_repository.dart';
import 'package:flutter_notes_app/service/db_service.dart';
import 'package:flutter_notes_app/ui/pages/add_note.dart';
import 'package:flutter_notes_app/ui/pages/note_details.dart';
import 'package:flutter_notes_app/ui/widgets/note_item.dart';
import 'package:provider/provider.dart';

class NotesHomPage extends StatefulWidget {
  @override
  _NotesHomPageState createState() => _NotesHomPageState();
}

class _NotesHomPageState extends State<NotesHomPage> {
  @override
  Widget build(BuildContext context) {
    UserRepository user = Provider.of<UserRepository>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Flutter Notes app"),
        actions: <Widget>[
          user.status == Status.Authenticating
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => user.signOut(),
                )
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: notesDb.streamList(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text("There was an error"),
              );
            if (!snapshot.hasData) return CircularProgressIndicator();

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => NoteItem(
                onTap: (note) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteDetailsPage(
                        note: note,
                      ),
                    )),
                note: snapshot.data[index],
                onEdit: (note) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddNotePage(note: note),
                    ),
                  );
                },
                onDelete: (note) async {
                  if (await _confirmDelete(context)) {
                    notesDb.removeItem(note.id);
                  }
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "add_note"),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Confirm Delete"),
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ));
  }
}
