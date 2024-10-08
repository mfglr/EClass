import 'package:flutter/material.dart';
import 'package:my_social_app/views/profile/pages/profile_menu_page/profile_menu_page.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
        Navigator
          .of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => const ProfileMenuPage()
            )
          ),
      icon: const Icon(Icons.menu),
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
        minimumSize: WidgetStateProperty.all(const Size(0, 0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}