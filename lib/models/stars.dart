import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  int stars_count;

  Stars({required this.stars_count});

  Widget Star(int min) {
    return Icon(
      stars_count > min ? Icons.star : Icons.star_border,
      color: Colors.mycolor1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Star(0),
        Star(1),
        Star(2),
        Star(3),
        Star(4),
      ],
    );
  }
}
