import 'package:whiteboard_swd/models/criteria.dart';
import 'package:intl/intl.dart';
import 'package:whiteboard_swd/models/university.dart';

class Campaign {
  String? id;
  String? name;
  String? campusName;
  String? startDay;
  String? endDay;
  String? image;
  String? university;
  String? description;
  String? universityName;
  bool? flag;

  List<Criteria>? campaignCriteria;

  Campaign({
    this.campaignCriteria,
    this.campusName,
    this.endDay,
    this.id,
    this.image,
    this.description,
    this.universityName,
    this.university,
    this.name,
    this.flag,
    this.startDay,
  });

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    campusName = json['campusName'];
    description = json['description'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    image = json['image'];
    universityName = json['universityName'];
    flag = false;

    var list = json['criterions'] as List;
    List<Criteria> criteriaList =
        list.map((e) => Criteria.fromJson(e)).toList();
    campaignCriteria = criteriaList;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['startDay'] = this.startDay;
  //   data['endDay'] = this.endDay;
  //   data['image'] = this.image;
  //   data['university'] = this.university;

  //   return data;
  // }
}

String parseDate(String? datetime) {
  DateTime dt = DateTime.parse(datetime!);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dt);

  return formattedDate;
}

DateTime toDate(String datetime) {
  DateTime dt = DateTime.parse(datetime);
  return dt;
}

int compareDate(String? campaignEndDate, d2) {
  DateTime d1 = DateTime.parse(campaignEndDate!);
  final formatter = DateFormat('dd/MM/yyyy');
  return d1.compareTo(d2);
  // d1 = DateTime.parse(campaignEndDate!);

  //return d1.compareTo(d2);
}


class Campaigns {
  List<Campaign>? listCampaign;

  Campaigns.fromJson(Map<String, dynamic> json) {
    var list = json['campaigns'] as List;
    List<Campaign> campaigns = list.map((e) => Campaign.fromJson(e)).toList();
    listCampaign = campaigns;
  }
}
