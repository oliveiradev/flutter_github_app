import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_app/router.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubRepoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchRepos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(children: mapDTOToWidget(snapshot.data));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Repo>> _fetchRepos() async {
    final response = await http.get("https://api.github.com/repositories");

    if (response.statusCode == 200) {
      final List items = json.decode(response.body);

      return items.map((item) => Repo.fromJSON(item)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<Widget> mapDTOToWidget(List<Repo> _repo) {
    return _repo.map((item) => _GithubRepoItemList(item)).toList();
  }
}

class _GithubRepoItemList extends StatelessWidget {
  final Repo repo;

  const _GithubRepoItemList(this.repo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(repo.owner.avatar)),
      title: Text(repo.name),
      subtitle: Text(repo.description),
      onTap: () {
        Router.navigateTo(context, '/pullrequests', arguments: repo.pulls);
      },
    );
  }
}

class Repo {
  final int id;
  final String name;
  final String description;
  final String pulls;
  final Owner owner;

  Repo({this.id, this.name, this.description, this.owner, this.pulls});

  factory Repo.fromJSON(Map<String, dynamic> json) {
    return Repo(
        id: json["id"],
        name: json["full_name"],
        description: json["description"] ?? "",
        pulls: json["pulls_url"],
        owner: Owner.fromJSON(json["owner"]));
  }
}

class Owner {
  final String name;
  final String avatar;

  Owner({this.name, this.avatar});

  factory Owner.fromJSON(Map<String, dynamic> json) {
    return Owner(name: json["login"], avatar: json["avatar_url"]);
  }
}
