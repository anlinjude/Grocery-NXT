import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.title, this.action,this.color});

  String? title = "";
  Widget? action;
  Color ?color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Colors.white,
      scrolledUnderElevation: 0,
      title: Text(
        title!,
        style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      actions: [action ?? const SizedBox()],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
