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
