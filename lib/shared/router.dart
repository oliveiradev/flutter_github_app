import 'package:flutter/widgets.dart';
import 'package:github_app/pullrequests/screens/pullrequests_screen.dart';

class Router {

  static Map<String, WidgetBuilder> registeredScreens = {
    GithubPullrequestList.router : (context) => GithubPullrequestList()
  };

  static navigateTo(BuildContext context, String name, { Object arguments }) {
    Navigator.pushNamed(context, name, arguments: arguments);
  }
}