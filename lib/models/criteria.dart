import 'package:flutter/material.dart';

class Criteria {
  String? id;
  String? name;
  String? namePost;

  double? rating;
  int? ratingPost;
  Criteria({
    this.id,
    this.rating,
    this.ratingPost,
    this.name,
    this.namePost,
  });

  Criteria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    namePost = json['criteriaName'];
    rating = json['averageRatings'];
    ratingPost = json['rating'];
  }
}
