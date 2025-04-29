import 'package:flutter/material.dart';
import 'package:qlct/common/button/add_button.dart';
import 'package:qlct/common/load_image/load_image.dart';
import 'package:qlct/generated/assets.dart';
import 'package:qlct/utilities/style/style.dart';
import '../../../generated/l10n.dart';

class BaseErrorDialog extends StatelessWidget {
  final String? message;
  final String? activeButton;
  final String? cancelButton;

  final VoidCallback? activeTap;
  final VoidCallback? cancelTap;

  const BaseErrorDialog({
    super.key,
    this.message,
    this.activeButton,
    this.cancelButton,
    this.activeTap,
    this.cancelTap,
  });


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.color.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                LoadImage(url:Assets.iconsIcEyeNew,height: 100,width: 100,),
                const SizedBox(height: 8),
                Text(
                  textAlign: TextAlign.center,
                  message ?? "",
                  style: theme.font.bigBold,
                ),
                const SizedBox(height: 20),
                AddButton(
                  title: activeButton ?? S.current.confirm,
                  onTap: () {
                    activeTap?.call();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 24,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
