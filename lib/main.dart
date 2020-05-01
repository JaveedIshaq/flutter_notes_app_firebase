import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/user_repository.dart';
import 'package:flutter_notes_app/ui/pages/add_note.dart';
import 'package:flutter_notes_app/ui/pages/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Notes',
        theme: ThemeData(
          primarySwatch: Colors.green,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.green,
            textTheme: ButtonTextTheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.grey.shade600,
              )),
        ),
        home: AuthHomePage(),
        routes: {
          "add_note": (_) => AddNotePage(),
        },
      ),
    );
  }
}
