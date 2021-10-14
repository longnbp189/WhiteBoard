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
  String? campusName;
  String? universityId;
  String? campusId;
  String? universityName;
  String? majorId;
  String? majorName;

  Reviewer(
      {this.token,
      this.name,
      this.id,
      this.avatar,
      this.email,
      this.majorId,
      this.majorName,
      this.publishedReviews,
      this.unpublishedReviews,
      this.waitingReviews,
      this.campusId,
      this.campusName,
      this.status,
      this.universityName,
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
    campusId = json['campusId'];
    majorId = json['majorId'];
    campusName = json['campusName'];
    universityId = json['universityId'];
    universityName = json['universityName'];
    status = json['status'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['token'] = this.token;
  //   data['name'] = this.name;
  //   data['avatar'] = this.avatar;
  //   data['email'] = this.email;
  //   data['publishedReviews'] = this.publishedReviews;
  //   data['unpublishedReviews'] = this.unpublishedReviews;
  //   data['waitingReviews'] = this.waitingReviews;
  //   data['campusName'] = this.campusName;
  //   data['campusId'] = this.campusId;
  //   data['universityName'] = this.universityName;
  //   data['majorId'] = this.majorId;
  //   data['universityId'] = this.universityId;
  //   data['status'] = this.status;
  //   return data;
  // }
}
