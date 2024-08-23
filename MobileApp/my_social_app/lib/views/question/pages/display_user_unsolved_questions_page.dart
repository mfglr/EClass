import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/user_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_entity_state/user_state.dart';
import 'package:my_social_app/views/question/widgets/question_items_widget.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';

class DisplayUserUnsolvedQuestionsPage extends StatelessWidget {
  final int userId;
  final int? firstDisplayedQuestionId;

  const DisplayUserUnsolvedQuestionsPage({
    super.key,
    required this.userId,
    this.firstDisplayedQuestionId
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,UserState>(
      converter: (store) => store.state.userEntityState.entities[userId]!,
      builder: (store,user) => Scaffold(
        appBar: AppBar(
          leading: const AppBackButtonWidget(),
          title: Text(
            "${user.userName}'s unsolved questions",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: StoreConnector<AppState,Iterable<QuestionState>>(
          onInit: (store) => store.dispatch(GetNextPageUserUnsolvedQuestionsIfNoPageAction(userId: userId)),
          converter: (store) => store.state.selectUserUnsolvedQuestions(userId),
          builder: (context,questions) => QuestionItemsWidget(
            firstDisplayedQuestionId: firstDisplayedQuestionId,
            questions: questions,
            pagination: user.unsolvedQuestions,
            onScrollBottom: (){
              final store = StoreProvider.of<AppState>(context,listen: false);
              store.dispatch(GetNextPageUserUnsolvedQuestionsIfReadyAction(userId: user.id));
            },
          ),
        ),
      ),
    );
  }
}