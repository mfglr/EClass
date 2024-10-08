import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/actions.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/topic_state.dart';


@immutable
class AddTopicsAction extends AppAction{
  final Iterable<TopicState> topics;
  const AddTopicsAction({required this.topics});
}
@immutable
class AddTopicsListAction extends AppAction{
  final Iterable<Iterable<TopicState>> lists;
  const AddTopicsListAction({required this.lists});
}

@immutable
class GetNextPageTopicQuestionsIfReadyAction extends AppAction{
  final int topicId;
  const GetNextPageTopicQuestionsIfReadyAction({required this.topicId});
}
@immutable
class GetNextPageTopicQuestionsIfNoPageAction extends AppAction{
  final int topicId;
  const GetNextPageTopicQuestionsIfNoPageAction({required this.topicId});
}
@immutable
class GetNextPageTopicQuestionsAction extends AppAction{
  final int topicId;
  const GetNextPageTopicQuestionsAction({required this.topicId});
}
@immutable
class AddNextPageTopicQuestionsAction extends AppAction{
  final int topicId;
  final List<int> questionIds;
  const AddNextPageTopicQuestionsAction({required this.topicId, required this.questionIds});
}

@immutable
class GetPrevPageTopicQuestionsIfReadyAction extends AppAction{
  final int topicId;
  const GetPrevPageTopicQuestionsIfReadyAction({required this.topicId});
}
@immutable
class GetPrevPageTopicQuestionsAction extends AppAction{
  final int topicId;
  const GetPrevPageTopicQuestionsAction({required this.topicId});
}
@immutable
class AddPrevPageTopicQuestionsAction extends AppAction{
  final int topicId;
  final Iterable<int> questionIds;
  const AddPrevPageTopicQuestionsAction({required this.topicId, required this.questionIds});
}