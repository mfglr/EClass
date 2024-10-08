import 'package:my_social_app/state/app_state/home_page_state/actions.dart';
import 'package:my_social_app/state/app_state/home_page_state/home_page_state.dart';
import 'package:redux/redux.dart';


HomePageState getNextPageQuestionsReducer(HomePageState prev,GetNextPageHomeQuestionsAction action)
  => prev.getNextPageQuestions();
HomePageState addNextPageQuestionsReducer(HomePageState prev,AddNextPageHomeQuestionsAction action)
  => prev.addNextPageQuestions(action.questionIds);
HomePageState getPrevPageQuestionsReducer(HomePageState prev,GetPrevPageHomeQuestionsAction action)
  => prev.getPrevPageQuestions();
HomePageState addPrevPageQuestionsReducer(HomePageState prev,AddPrevPageHomeQuestionsAction action)
  => prev.addPrevPageQuestions(action.questionIds);
HomePageState prependQuestionReducer(HomePageState prev,AddHomePageQuestionAction action)
  => prev.prependQuestion(action.questionId);


Reducer<HomePageState> homePageReducers = combineReducers<HomePageState>([
  TypedReducer<HomePageState,GetNextPageHomeQuestionsAction>(getNextPageQuestionsReducer).call,
  TypedReducer<HomePageState,AddNextPageHomeQuestionsAction>(addNextPageQuestionsReducer).call,
  TypedReducer<HomePageState,GetPrevPageHomeQuestionsAction>(getPrevPageQuestionsReducer).call,
  TypedReducer<HomePageState,AddPrevPageHomeQuestionsAction>(addPrevPageQuestionsReducer).call,
  TypedReducer<HomePageState,AddHomePageQuestionAction>(prependQuestionReducer).call,
]);