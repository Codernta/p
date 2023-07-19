import 'package:flutter/material.dart';
import 'package:ipix_mt/Utils/widgets/rating_widget.dart';

class RatingAndReviewCard extends StatefulWidget {
  final String ratings;
  final String userName;
  final String review;
  final String date;
  const RatingAndReviewCard(
      {super.key,
      required this.ratings,
      required this.userName,
      required this.date,
      required this.review});

  @override
  State<RatingAndReviewCard> createState() => _RatingAndReviewCardState();
}

class _RatingAndReviewCardState extends State<RatingAndReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              RatingWidget(
                rating: widget.ratings,
              ),
              SizedBox(
                width: 15,
              ),
              Text(widget.userName)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.review,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 15,
          ),
          Text(widget.date)
        ],
      ),
    );
  }
}
