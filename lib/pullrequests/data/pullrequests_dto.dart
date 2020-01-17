import 'package:github_app/repositories/data/repos_dto.dart';

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