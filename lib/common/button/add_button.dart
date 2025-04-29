import 'package:flutter/material.dart';
import 'package:qlct/utilities/style/style.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? icon;
  final VoidCallback? onTap;

  const AddButton(
      {super.key,
      required this.title,
      this.textColor,
      this.backgroundColor,
      this.onTap,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Stack(
        children: [
          // Nền chính
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: backgroundColor ?? theme.color.yellowPrimary,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,

          ),

          // Inner shadow layer
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                boxShadow:   [
                  BoxShadow(
                    color: theme.color.white.withOpacity(0.25), // #FFFFFF40 = 40 hex = 25% opacity
                    offset: const Offset(-16, -16),
                    blurRadius: 48,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: theme.color.white.withOpacity(0.25),
                    offset: const Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: icon!,
                  ),
                Text(
                  title,
                  style: theme.font.text14s
                      .copyWith(color: textColor ?? theme.color.brownPrimary),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
