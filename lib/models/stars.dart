import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  int stars_count;
  bool isDark;

  Stars({required this.stars_count, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: isDark ?Colors.mycolor1 : Colors.mycolor4,
        ),
        Icon(
          stars_count > 1 ? Icons.star : Icons.star_border,
          color: isDark ?Colors.mycolor1 : Colors.mycolor4,
        ),
        Icon(
          stars_count > 2 ? Icons.star : Icons.star_border,
          color: isDark ?Colors.mycolor1 : Colors.mycolor4,
        ),
        Icon(
          stars_count > 3 ? Icons.star : Icons.star_border,
          color: isDark ?Colors.mycolor1 : Colors.mycolor4,
        ),
        Icon(
          stars_count > 4 ? Icons.star : Icons.star_border,
          color: isDark ?Colors.mycolor1 : Colors.mycolor4,
        ),
      ],
    );
  }
}
