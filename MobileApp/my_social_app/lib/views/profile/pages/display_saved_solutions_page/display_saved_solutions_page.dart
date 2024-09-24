import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/solution_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/user_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_entity_state/user_state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/shared/app_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_social_app/views/shared/loading_view.dart';
import 'package:my_social_app/views/solution/widgets/solution_items_widget.dart';

class DisplaySavedSolutionsPage extends StatelessWidget {
  final int? solutionId;
  const DisplaySavedSolutionsPage({
    super.key,
    this.solutionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButtonWidget(),
        title: AppTitle(
          title: AppLocalizations.of(context)!.display_saved_solutions_page_title,
        ),
      ),
      body: StoreConnector<AppState,UserState?>(
        onInit: (store) => store.dispatch(LoadUserAction(userId: store.state.accountState!.id)),
        converter: (store) => store.state.currentUser,
        builder: (context,user){
          if(user == null) return const LoadingView();
          return StoreConnector<AppState,Iterable<SolutionState>>(
            onInit: (store) => store.dispatch(GetNextPageUserSavedSolutionsIfNoPageAction(userId: store.state.accountState!.id)),
            converter: (store) => store.state.selectUserSavedSolutions(store.state.accountState!.id),
            builder: (context,solutions) => SolutionItemsWidget(
              pagination: user.savedSolutions,
              solutions: solutions,
              solutionId: solutionId,
              onScrollBottom: (){
                final store = StoreProvider.of<AppState>(context,listen: false);
                store.dispatch(GetNextPageUserSavedSolutionsIfReadyAction(userId: store.state.accountState!.id));
              }
            ),
          );
        },
      ),
    );
  }
}