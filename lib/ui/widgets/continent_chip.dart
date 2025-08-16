import 'package:flutter/material.dart';

class ContinentChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const ContinentChip({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          width: 600, // 横幅ちょっと広め
          height: 400, // 縦幅をしっかり大きく
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent.shade100, // パステル黄緑
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
              fontSize: 24, // 大きめの文字
              fontWeight: FontWeight.bold,
              color: Colors.black87, // 黒字で可読性UP
            ),
          ),
        ),
      ),
    );
  }
}
