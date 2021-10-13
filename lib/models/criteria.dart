class Criteria {
  String? id;
  String? name;
  String? namePost;

  Criteria({
    this.id,
    this.name,
    this.namePost,
  });

  Criteria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    namePost = json['criteriaName'];
  }
}
