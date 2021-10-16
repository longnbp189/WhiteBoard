import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/criteria.dart';


class CriteriaList{
//List<Criteria>? campaignCriteria;
//CriteriaList({required this.campaignCriteria});

List<Widget> createCriteriaList(List<Criteria>? campaignCriteria, double iFontSize) {
    List<Widget> criList = [];
    for (var i = 0; i < campaignCriteria!.length; i++) {
      criList.add(
        Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 5),
          child: Container(
            padding: EdgeInsets.all(iFontSize*0.25),
            decoration: BoxDecoration(
              color: Colors.black87,
              //borderRadius: BorderRadius.circular(3),
              border: Border.all(width: 1),
            ),
            child: Text(
              campaignCriteria[i].name.toString(),
              style: TextStyle(fontSize: iFontSize, color: Colors.white),
            ),
          ),
        ),
      );
    }
    return criList;
  }
}
