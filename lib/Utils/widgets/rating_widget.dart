import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final String rating;
  const RatingWidget({super.key,required this.rating});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.green.shade800, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.rating+ '  ',style: TextStyle(color: Colors.white),),
          Icon(
            Icons.star,
            size: 12,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
