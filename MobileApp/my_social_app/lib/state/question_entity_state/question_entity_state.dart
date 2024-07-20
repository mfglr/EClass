import 'package:flutter/material.dart';
import 'package:my_social_app/state/entity_state.dart/entity_state.dart';
import 'package:my_social_app/state/question_entity_state/question_state.dart';

@immutable
class QuestionEntityState extends EntityState<QuestionState>{
  const QuestionEntityState({required super.entities});
  
  QuestionEntityState addQuestion(QuestionState value)
    => QuestionEntityState(entities: addOneStart(value));
  QuestionEntityState addQuestions(Iterable<QuestionState> values)
    => QuestionEntityState(entities: addManyEnd(values));
  QuestionEntityState like(int questionId)
    => QuestionEntityState(entities: updateOne(entities[questionId]!.like()));
  QuestionEntityState dislike(int questionId)
    => QuestionEntityState(entities: updateOne(entities[questionId]!.dislike()));


  Iterable<QuestionState> getByUserId(int userId)
    => entities.values.where((question) => question.appUserId == userId);
  Iterable<QuestionState> getByTopicId(int topicId)
    => entities.values.where((question) => question.topics.any((id) => id == topicId));
  Iterable<QuestionState> getBySubjectId(int subjectId)
    => entities.values.where((question) => question.subjectId == subjectId);
}