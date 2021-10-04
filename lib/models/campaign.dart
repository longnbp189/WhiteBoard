import 'package:whiteboard_swd/models/criteria.dart';
import 'package:intl/intl.dart';

class Campaign {
  String? id;
  String? name;
  String? description;
  String? startDay;
  String? endDay;
  String? image;
  String? school;
  String? campus;

  List<Criteria>? campaignCriteria;

  Campaign(
      {this.campaignCriteria,
      this.description,
      this.endDay,
      this.id,
      this.image,
      this.school,
      this.campus,
      this.name,
      this.startDay});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    image = json['image'];
    school = json['school'];
    campus = json['campus'];

    var list = json['campaignCriteria'] as List;
    List<Criteria> criteriaList =
        list.map((e) => Criteria.fromJson(e)).toList();
    campaignCriteria = criteriaList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['startDay'] = this.startDay;
    data['endDay'] = this.endDay;
    data['image'] = this.image;
    data['school'] = this.school;
    data['campus'] = this.campus;

    return data;
  }
}

String parseDate(String? datetime) {
  DateTime dt = DateTime.parse(datetime!);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dt);

  return formattedDate;
}
