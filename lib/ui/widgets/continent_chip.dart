// lib/ui/widgets/continent_chip.dart
import 'package:flutter/material.dart';

class ContinentChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final GestureLongPressStartCallback? onLongPressStart;

  const ContinentChip({
    super.key,
    required this.label,
    this.onTap,
    this.onLongPressStart,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        onLongPressStart: onLongPressStart,
        child: Container(
          width: 600,
          height: 400,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent.shade100,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}