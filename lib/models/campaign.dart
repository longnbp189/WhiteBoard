import 'package:whiteboard_swd/models/criteria.dart';
import 'package:intl/intl.dart';
import 'package:whiteboard_swd/models/university.dart';

class Campaign {
  String? id;
  String? name;
  String? description;
  String? startDay;
  String? endDay;
  String? image;
  String? university;
  String? campus;

  List<Criteria>? campaignCriteria;
  List<UniversityOfCompaign>? unis;

  Campaign(
      {this.campaignCriteria,
      this.description,
      this.endDay,
      this.id,
      this.image,
      this.university,
      this.campus,
      this.name,
      this.startDay,
      this.unis});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    image = json['image'];
    university = json['university'];
    campus = json['campus'];

    var list = json['campaignCriteria'] as List;
    List<Criteria> criteriaList =
        list.map((e) => Criteria.fromJson(e)).toList();
    campaignCriteria = criteriaList;

    var listU = json['campaignOns'] as List;
    List<UniversityOfCompaign> uList =
        listU.map((e) => UniversityOfCompaign.fromJson(e)).toList();
    unis = uList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['startDay'] = this.startDay;
    data['endDay'] = this.endDay;
    data['image'] = this.image;
    data['university'] = this.university;
    data['campus'] = this.campus;

    return data;
  }
}

String parseDate(String? datetime) {
  DateTime dt = DateTime.parse(datetime!);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dt);

  return formattedDate;
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
