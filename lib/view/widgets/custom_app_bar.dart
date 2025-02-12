import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isLeading;
  final Color? leadingColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.isLeading = true,  this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isLeading
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: leadingColor ??AppColor.primaryColorDark),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      backgroundColor: AppColor.secondaryBackgroundColor,
      title: Text(
        title,
        style: isLeading?  TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color:leadingColor ?? AppColor.primaryColorDark,
      ) : Theme.of(context).textTheme.headlineSmall,
      ),
      centerTitle: !isLeading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}