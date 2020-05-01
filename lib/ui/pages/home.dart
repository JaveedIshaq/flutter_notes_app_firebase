import 'package:flutter/material.dart';
import 'package:flutter_notes_app/ui/pages/login.dart';

import 'package:flutter_notes_app/ui/pages/notes_home.dart';
import '../../model/user_repository.dart';
import 'package:provider/provider.dart';
import './splash.dart';

class AuthHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserRepository user, _) {
        switch (user.status) {
          case Status.Uninitialized:
            return Splash();
          case Status.Unauthenticated:
          case Status.Authenticating:
            return LoginView();
          case Status.Authenticated:
            return NotesHomPage();
        }
        return Splash();
      },
    );
  }
}
