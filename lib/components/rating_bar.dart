import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:whiteboard_swd/utils/color.dart';

class Rating extends StatefulWidget {
  final Function callback;
  final String id;
  final int initStar;
  const Rating(
      {Key? key,
      required this.callback,
      required this.id,
      required this.initStar})
      : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  Icon ratingIcon = Icon(
    Icons.star,
    color: Colors.amber,
  );
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      initialRating: widget.initStar.toDouble(),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      ratingWidget: RatingWidget(
        empty: Icon(
          Icons.star_outline,
          color: Colors.amber,
        ),
        full: ratingIcon,
        half: ratingIcon,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          ratingIcon = Icon(
            Icons.star,
            color: Colors.amber,
          );
          widget.callback(rating, widget.id);
        });
      },
    );
  }
}
