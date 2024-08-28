import 'package:my_social_app/state/app_state/exam_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/exam_entity_state/exam_entity_state.dart';
import 'package:my_social_app/state/pagination/id_state.dart';
import 'package:redux/redux.dart';

ExamEntityState getNextPageExamQuestionsReducer(ExamEntityState prev,GetNextPageExamQuestionsAction action)
  => prev.getNextPageQuestions(action.examId);
ExamEntityState addNextPageExamQuestionsReducer(ExamEntityState prev,AddNextPageExamQuestionsAction action)
  => prev.addNextPageQuestions(action.examId, action.questionIds.map((e) => IdState(key: e)));

ExamEntityState getAllExamsReducer(ExamEntityState prev,GetAllExamsAction action)
  => prev.getAllExams();
ExamEntityState addAllExamsReducer(ExamEntityState prev,AddAllExamsAction action)
  =>prev.addAllExams(action.exams);

ExamEntityState addExamReducer(ExamEntityState prev,AddExamAction action)
  => prev.addExam(action.exam);
ExamEntityState addExamsReducer(ExamEntityState prev,AddExamsAction action)
  => prev.addExams(action.exams);
ExamEntityState loadSubjectsOfSelectedExamSuccessReducer(ExamEntityState prev,GetExamSubjectsSuccessAction action)
  =>prev.loadExamSubjects(action.examId, action.ids.map((e) => IdState(key: e)));

Reducer<ExamEntityState> examEntityStateReducers = combineReducers<ExamEntityState>([
  TypedReducer<ExamEntityState,GetNextPageExamQuestionsAction>(getNextPageExamQuestionsReducer).call,
  TypedReducer<ExamEntityState,AddNextPageExamQuestionsAction>(addNextPageExamQuestionsReducer).call,

  TypedReducer<ExamEntityState,AddExamAction>(addExamReducer).call,
  TypedReducer<ExamEntityState,AddExamsAction>(addExamsReducer).call,
  TypedReducer<ExamEntityState,AddAllExamsAction>(addAllExamsReducer).call,
  
  TypedReducer<ExamEntityState,GetExamSubjectsSuccessAction>(loadSubjectsOfSelectedExamSuccessReducer).call,
]);