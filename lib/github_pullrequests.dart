import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_app/github_repo.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubPullrequestList extends StatelessWidget {
  static final String router = '/pullrequests';

  @override
  Widget build(BuildContext context) {
    final String pullrequestUrl = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        // Add 6 lines from here...
        appBar: AppBar(
          title: Text('Pullrequests'),
        ),
        body: Center(
          child: FutureBuilder(
            future: _fetchPulls(pullrequestUrl),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(children: _mapDTOToWidget(snapshot.data));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Future<List<Pullrequest>> _fetchPulls(final String pulls) async {
    final response = await http.get(sanitizePullsUrl(pulls));

    if (response.statusCode == 200) {
      final List items = json.decode(response.body);

      return items.map((item) => Pullrequest.fromJSON(item)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<Widget> _mapDTOToWidget(final List<Pullrequest> pulls) {
    return pulls.map((data) => _GithubPullrequestItemList(data)).toList();
  }

  String sanitizePullsUrl(final String url) {
    return url.replaceAll("{/number}", "");
  }
}

class _GithubPullrequestItemList extends StatelessWidget {
  final Pullrequest pullrequest;

  _GithubPullrequestItemList(this.pullrequest);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(pullrequest.owner.avatar)),
        title: Text(pullrequest.title));
  }
}

class Pullrequest {
  final String title;
  final String body;
  final Owner owner;

  Pullrequest({this.title, this.body, this.owner});

  factory Pullrequest.fromJSON(final Map<String, dynamic> json) {
    return Pullrequest(
        title: json['title'],
        body: json['body'],
        owner: Owner.fromJSON(json['user']));
  }
}
