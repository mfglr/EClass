import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/user_entity_state/actions.dart';
import 'package:my_social_app/state/user_entity_state/user_state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/question/widgets/question_items_widget.dart';

class DisplayUserQuestionsPage extends StatelessWidget {
  final int userId;
  final int questionIndex;
  
  const DisplayUserQuestionsPage({
    super.key,
    required this.userId,
    required this.questionIndex
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,UserState>(
      converter: (store) => store.state.userEntityState.entities[userId]!,
      builder: (store,user) => Scaffold(
        appBar: AppBar(
          leading: const AppBackButtonWidget(),
          title: Text(
            "${user.formatName(10)}'s questions",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        body: StoreConnector<AppState,Iterable<QuestionState>>(
          onInit: (store) => store.dispatch(GetNextPageUserQuestionsIfNoPageAction(userId: userId)),
          converter: (store) => store.state.selectUserQuestions(userId),
          builder: (context,questions) => QuestionItemsWidget(
            questionIndex: questionIndex,
            questions: questions,
            pagination: user.questions,
            onScrollBottom: (){
              final store = StoreProvider.of<AppState>(context,listen: false);
              store.dispatch(GetNextPageUserQuestionsIfReadyAction(userId: user.id));
            },
          ),
        ),
      ),
    );
  }
}