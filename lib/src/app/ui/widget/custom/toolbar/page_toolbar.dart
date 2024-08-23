
import 'package:flutter/material.dart';
import 'package:movie_box/res/colors.dart';

class PageToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String textTitle;
  final bool isShowBackBtn;


  PageToolbar({super.key, required this.textTitle, this.isShowBackBtn = false}) {

  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isShowBackBtn ? IconButton(
        icon: const Icon(Icons.arrow_back, color: UiColors.blueGray_900),
        onPressed: () => Navigator.of(context).pop(),
      ) : const SizedBox.shrink(),
      centerTitle: true,
      title: Text(textTitle, style: const TextStyle(color: UiColors.blueGray_900),),
      backgroundColor: UiColors.amber_700,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
