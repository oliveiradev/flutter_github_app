import 'package:flutter/material.dart';
import 'package:github_app/shared/router.dart';

import 'repositories/screens/repos_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Router.registeredScreens,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Github app"),
          ),
          body: Center(
            child: GithubRepoList(),
          )
      )
    );
  }
}
