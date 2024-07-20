import 'package:my_social_app/services/exam_service.dart';
import 'package:my_social_app/services/question_service.dart';
import 'package:my_social_app/services/subject_service.dart';
import 'package:my_social_app/state/exam_entity_state/actions.dart';
import 'package:my_social_app/state/question_entity_state/actions.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/subject_entity_state/actions.dart';
import 'package:my_social_app/state/topic_entity_state/actions.dart';
import 'package:redux/redux.dart';

void loadAllExamsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadAllExamsAction){
    if(!store.state.examEntityState.isLoaded){
      ExamService()
        .getAll()
        .then(
          (exams) => store.dispatch(
            LoadAllExamsSuccessAction(
              exams: exams.map((e) => e.toExamState())
            )
          )
        );
    }
  }
  next(action);
}

void nextPageOfExamQeuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is NextPageOfExamQuestionsAction){
    final examState = store.state.examEntityState.exams[action.examId]!;
    if(!examState.questions.isLast){
      QuestionService()
        .getByExamId(action.examId,lastId: examState.questions.lastId)
        .then((questions){
          store.dispatch(
            AddQuestionsAction(
              questions: questions.map((e) => e.toQuestionState())
            )
          );
          
          store.dispatch(
            NextPageOfExamQuestionsSuccessAction(
              examId: action.examId,
              questionIds: questions.map((x) => x.id)
            )
          );

          store.dispatch(
            AddExamsAction(
              exams: questions.map((e) => e.exam.toExamState()) 
            )
          );

          store.dispatch(
            AddSubjectsAction(
              subjects: questions.map((e) => e.subject.toSubjectState())
            )
          );

          for(final q in questions){
            store.dispatch(LoadTopicsSuccessAction(
              topics: q.topics.map((e) => e.toTopicState()))
            );
          }
        });
    }
  }
  next(action);
}

void loadSubjectsOfSelectedExamReducer(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadSubjectsOfSelectedExamAction){
    final examId = store.state.createQuestionState.examId!;
    final examState = store.state.examEntityState.exams[examId]!;
    if(!examState.subjects.isLast){
      SubjectService()
        .getByExamId(examId)
        .then((subjects){
          store.dispatch(
            AddSubjectsAction(
              subjects: subjects.map((e) => e.toSubjectState())
            )
          );

          store.dispatch(
            LoadSubjectsOfSelectedExamSuccessAction(
              examId: examId,
              ids: subjects.map((e) => e.id)
            )
          );
        });
    }
  }
  next(action);
}