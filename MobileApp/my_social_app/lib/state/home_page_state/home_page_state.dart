import 'package:my_social_app/state/pagination.dart';

class HomePageState{
  final Pagination questions;
  const HomePageState({required this.questions});

  HomePageState getNextPageQuestions() => HomePageState(questions: questions.startLoading());
  HomePageState addNextPageQuestions(Iterable<int> questionIds) => HomePageState(questions: questions.appendNextPage(questionIds));
  HomePageState getPrevPageQuestions() => HomePageState(questions: questions.startLoadingPrev());
  HomePageState addPrevPageQuestions(Iterable<int> questionIds) => HomePageState(questions: questions.addPrevPage(questionIds));
  HomePageState prependQuestion(int questionId) => HomePageState(questions: questions.prependOne(questionId));

}