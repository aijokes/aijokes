import 'package:flutter/material.dart';

import '../app/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? height;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.backgroundColor = Colors.red,
    this.height = 60.0,
    this.leadingIcon,
    this.onLeadingPressed,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(
        text: title,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: Icon(leadingIcon),
        onPressed: onLeadingPressed,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
