import 'package:flutter/material.dart';
import 'package:my_social_app/state/pagination/pagination.dart';

@immutable
class SubjectState{
  final int id;
  final int examId;
  final String name;
  final Pagination topics;
  final Pagination questions;
  
  const SubjectState({
    required this.id,
    required this.examId,
    required this.name,
    required this.topics,
    required this.questions
  });

  SubjectState getNextPageQuestions()
    => SubjectState(
        id: id,
        examId: examId,
        name: name,
        topics: topics,
        questions: questions.startLoadingNext()
      );
  SubjectState addNextPageQuestions(Iterable<int> ids)
    => SubjectState(
        id: id,
        examId: examId,
        name: name,
        topics: topics,
        questions: questions.addNextPage(ids)
      );

  SubjectState getPrevPageQuestions()
    => SubjectState(
        id: id,
        examId: examId,
        name: name,
        topics: topics,
        questions: questions.startLoadingPrev()
      );
  SubjectState addPrevPageQuestions(Iterable<int> questionIds)
    => SubjectState(
        id: id,
        examId: examId,
        name: name,
        topics: topics,
        questions: questions.addPrevPage(questionIds)
      );

  SubjectState startloading()
    => SubjectState(
        id: id,
        examId: examId,
        name: name,
        topics: topics.startLoadingNext(),
        questions: questions
      );

  SubjectState adNextPageTopics(Iterable<int> ids)
    => SubjectState(
        id: id,
        examId: examId,
        name: name,
        topics: topics.appendLastPage(ids),
        questions: questions
      );
}
