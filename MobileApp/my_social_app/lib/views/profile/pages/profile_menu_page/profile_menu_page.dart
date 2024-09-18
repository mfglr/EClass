import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/account_state/actions.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/utilities/dialog_creator.dart';
import 'package:my_social_app/views/profile/pages/display_abstract_saved_questions_page/display_abstract_saved_questions_page.dart';
import 'package:my_social_app/views/profile/pages/profile_menu_page/widgets/profile_menu_item.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/shared/app_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButtonWidget(),
        title: AppTitle(title: AppLocalizations.of(context)!.profile_menu_page_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfileMenuItem(
              name: AppLocalizations.of(context)!.profile_menu_page_saves_item,
              icon: Icons.bookmark,
              onPressed: () =>
                Navigator
                  .of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => const DisplayAbstractSavedQuestionsPage() 
                    )
                  ),
            ),
            ProfileMenuItem(
              name: "Çıkış yap",
              icon: Icons.logout,
              displayRightArrow: false,
              iconColor: Colors.red,
              nameColor: Colors.red,
              onPressed: (){
                DialogCreator
                  .showLogOutDialog(context)
                  .then((value){
                    if(value){
                      final store = StoreProvider.of<AppState>(context,listen: false);
                      store.dispatch(const LogOutAction());
                      Navigator.of(context).pop();
                    }
                  });
              }
            )
          ],
        ),
      ),
    );
  }
}