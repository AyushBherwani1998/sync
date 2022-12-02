import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SyncButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? textColor;
  final Color? bgColor;

  const SyncButton({
    this.onTap,
    required this.label,
    this.icon,
    this.textColor,
    this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: bgColor,
            ),
            onPressed: onTap,
            icon: (icon == null) ? const Offstage() : icon!,
            label: label.text.size(18).color(textColor).make(),
          ),
        ),
      ],
    ).pSymmetric(v: 8, h: 12);
  }
}
