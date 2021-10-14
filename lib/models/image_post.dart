class ImagePost {
  String? id;
  String? picture;

  ImagePost({
    this.id,
    this.picture,
  });

  ImagePost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
  }
}
