class Criteria {
  String? id;
  String? name;

  Criteria({
    this.id,
    this.name,
  });

  Criteria.fromJson(Map<String, dynamic> json) {
    id = json['criteria']['id'];
    name = json['criteria']['name'];
  }
}
