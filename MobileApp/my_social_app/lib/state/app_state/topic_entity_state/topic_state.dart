import 'package:flutter/material.dart';
import 'package:my_social_app/state/pagination/pagination.dart';

@immutable
class TopicState{
  final int id;
  final String name;
  final Pagination questions;

  const TopicState({
    required this.id,
    required this.name,
    required this.questions
  });

  TopicState getNextPageQuestions()
    => TopicState(
        id: id,
        name: name,
        questions: questions.startLoadingNext(),
      );
  TopicState addNextPageQuestions(Iterable<int> quesionIds)
    => TopicState(
        id: id,
        name: name,
        questions: questions.addNextPage(quesionIds),
      );

  TopicState getPrevPageQuestions()
    => TopicState(
        id: id,
        name: name,
        questions: questions.startLoadingPrev()
      );
  TopicState addPrevPageQuestions(Iterable<int> questionIds)
    => TopicState(
        id: id,
        name: name,
        questions: questions.addPrevPage(questionIds)
      );
    
  TopicState addQuestionId(int questionId)
    => TopicState(
        id: id,
        name: name,
        questions: questions.prependOne(questionId)
      );
  TopicState removeQuestionId(int questionId)
    => TopicState(
        id: id,
        name: name,
        questions: questions.removeOne(questionId)
      );
}
