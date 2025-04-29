import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qlct/common/button/add_button.dart';
import 'package:qlct/utilities/style/style.dart';
import '../../../generated/l10n.dart';

class DialogNotiPermisson extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? icon;
  final String? activeButton;
  final String? cancelButton;

  final VoidCallback? activeTap;
  final VoidCallback? cancelTap;

  const DialogNotiPermisson(
      {super.key,
        this.title,
        this.message,
        this.icon,
        this.activeButton,
        this.cancelButton,
        this.activeTap,
        this.cancelTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            // height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: theme.color.white,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  title ?? S.current.notification,
                  style: theme.font.text18bold
                      .copyWith(color: theme.color.brownPrimary),
                ),
                const SizedBox(height: 6,),
                Text(
                  textAlign: TextAlign.center,
                  message ?? "",
                  style: theme.font.text14w400
                      .copyWith(color: theme.color.textNormal),
                ),
                const SizedBox(
                  height: 16,
                ),
                AddButton(
                  title: activeButton ?? S.current.confirm,
                  onTap: () {
                    activeTap?.call();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                if (cancelButton != null)
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        cancelTap?.call();
                      },
                      child: Text(
                        cancelButton ?? S.current.cancel,
                        style: theme.font.text14s
                            .copyWith(color: theme.color.brownCancel),
                      ))
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 12,
              child: IconButton(
                  onPressed: () {
                    // SystemNavigator.pop();
                    exit(0);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                  )))
        ],
      ),
    );
  }
}
