class Reviewer {
  String? token;
  String? id;
  String? name;
  String? avatar;
  String? email;
  int? publishedReviews;
  int? unpublishedReviews;
  int? waitingReviews;
  String? status;
  String? campus;
  String? universityId;
  String? campusId;
  String? university;
  String? majorId;

  Reviewer(
      {this.token,
      this.name,
      this.id,
      this.avatar,
      this.email,
      this.majorId,
      this.publishedReviews,
      this.unpublishedReviews,
      this.waitingReviews,
      this.campusId,
      this.campus,
      this.status,
      this.university,
      this.universityId});

  Reviewer.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    publishedReviews = json['publishedReviews'];
    unpublishedReviews = json['unpublishedReviews'];
    waitingReviews = json['waitingReviews'];
    campusId = json['campusMajor']['campusId'];
    majorId = json['campusMajor']['majorId'];
    campus = json['campusMajor']['campus']['name'];
    universityId = json['campusMajor']['campus']['universityId'];
    university = json['campusMajor']['campus']['university']['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['publishedReviews'] = this.publishedReviews;
    data['unpublishedReviews'] = this.unpublishedReviews;
    data['waitingReviews'] = this.waitingReviews;
    data['campusMajor']['campus']['name'] = this.campus;
    data['campusMajor']['campusId'] = this.campusId;
    data['campusMajor']['campus']['university']['name'] = this.university;
    data['campusMajor']['majorId'] = this.majorId;
    data['campusMajor']['campus']['universityId'] = this.universityId;
    data['status'] = this.status;
    return data;
  }
}
