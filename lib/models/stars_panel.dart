import 'package:flutter/material.dart';
import 'package:litera_vibe/db/mark_db.dart';

class StarsPanel extends StatefulWidget {
  int stars_count;
  void Function(int) onUpdate;
  StarsPanel({required this.stars_count, required this.onUpdate});

  @override
  State<StarsPanel> createState() => _StarsPanelState();
}

class _StarsPanelState extends State<StarsPanel> {
  int stars_count = 1;

  @override
  void initState() {
    stars_count = widget.stars_count;
    super.initState();
  }

  @override
  void didUpdateWidget(StarsPanel oldWidget) {
    if (oldWidget.stars_count != widget.stars_count) {
      setState(() {
        stars_count = widget.stars_count; // Обновление значения при изменении props
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  Widget Star(int min) {
    return Container(
      width: 35,
      height: 40,
      // color: Colors.blue,
      child: Center(
        child: IconButton(
          onPressed: (){
            widget.onUpdate(min+1);
            setState(() {
              stars_count = min+1;
            });
          },
          icon: Icon(
            stars_count > min ? Icons.star : Icons.star_border,
            color: Colors.mycolor4,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Уменьшает размер основной оси (горизонтально)
      mainAxisAlignment: MainAxisAlignment.start, // Выравнивание в начале основной оси
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
