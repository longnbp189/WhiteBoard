class Criteria {
  String? id;
  String? name;

  Criteria({
    this.id,
    this.name,
  });

  Criteria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
