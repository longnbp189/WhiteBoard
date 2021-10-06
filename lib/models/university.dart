class UniversityOfCompaign {
  String? universityName;
  String? campusName;

  UniversityOfCompaign({this.campusName, this.universityName});

  UniversityOfCompaign.fromJson(Map<String, dynamic> json) {
    universityName = json['campusMajor']['campus']['university']['name'];
    campusName = json['campusMajor']['campus']['name'];
  }
}
