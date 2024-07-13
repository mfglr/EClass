import 'package:my_social_app/services/exam_service.dart';
import 'package:my_social_app/state/exams_state/actions.dart';
import 'package:my_social_app/state/state.dart';
import 'package:redux/redux.dart';

void loadExamsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadExamsAction){
    if(!store.state.examsState.isLoaded){
      ExamService()
      .getAll()
      .then((exams) => store.dispatch(LoadExamSuccessAction(payload: exams.map((e) => e.toExamState()).toList())));
    }
  }
  next(action);
}