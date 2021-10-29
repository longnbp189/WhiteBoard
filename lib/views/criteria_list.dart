import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/utils/color.dart';

class CriteriaList {
//List<Criteria>? campaignCriteria;
//CriteriaList({required this.campaignCriteria});

  List<Widget> createCriteriaList(
      List<Criteria>? campaignCriteria, double iFontSize) {
    List<Widget> criList = [];
    for (var i = 0; i < campaignCriteria!.length; i++) {
      criList.add(
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: Container(
            padding: EdgeInsets.all(iFontSize * 0.4),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: white_blue),
              //color: Colors.lightBlue[100],
              borderRadius: BorderRadius.circular(iFontSize),
              //border: Border.all(width: 1),
            ),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  campaignCriteria[i].name.toString(),
                  style: TextStyle(fontSize: iFontSize, color: white_blue),
                ),
                if (campaignCriteria[i].rating != null &&
                    campaignCriteria[i].rating != 0.0)
                  Wrap(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        campaignCriteria[i].rating.toString(),
                        style:
                            TextStyle(fontSize: iFontSize, color: Colors.black),
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return criList;
  }
}
