import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/question_entity_state/question_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/topic_state.dart';
import 'package:my_social_app/views/shared/app_back_button_widget.dart';
import 'package:my_social_app/views/question/widgets/question_items_widget.dart';

class DisplayTopicQuestionsPage extends StatelessWidget {
  final int topicId;
  const DisplayTopicQuestionsPage({super.key, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,TopicState>(
      converter: (store) => store.state.topicEntityState.entities[topicId]!,
      builder: (context,topic) =>  Scaffold(
        appBar: AppBar(
          leading: const AppBackButtonWidget(),
          title: Text(
            "Topic: ${topic.name}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: StoreConnector<AppState,Iterable<QuestionState>>(
          onInit: (store) => store.dispatch(GetNextPageTopicQuestionsIfNoPageAction(topicId: topicId)),
          converter: (store) => store.state.selectTopicQuestions(topicId),
          builder: (context,questions) => QuestionItemsWidget(
            questions: questions.toList(),
            pagination: topic.questions,
            onScrollBottom: (){
              final store = StoreProvider.of<AppState>(context,listen: false);
              store.dispatch(GetNextPageTopicQuestionsIfReadyAction(topicId: topicId));
            },
          ),
        ),
      ),
    );
  }
}