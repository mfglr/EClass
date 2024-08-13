import 'package:my_social_app/constants/record_per_page.dart';
import 'package:my_social_app/services/question_service.dart';
import 'package:my_social_app/services/user_service.dart';
import 'package:my_social_app/state/exam_entity_state/actions.dart';
import 'package:my_social_app/state/question_entity_state/actions.dart';
import 'package:my_social_app/state/question_image_entity_state/actions.dart';
import 'package:my_social_app/state/search_state/actions.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/subject_entity_state/actions.dart';
import 'package:my_social_app/state/topic_entity_state/actions.dart';
import 'package:my_social_app/state/user_entity_state/actions.dart';
import 'package:my_social_app/state/user_image_entity_state/actions.dart';
import 'package:my_social_app/state/user_image_entity_state/user_image_state.dart';
import 'package:redux/redux.dart';

void getFirstPageSearchingUsersIfNoPageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetFirstPageSearchingUsersIfNoPageAction){
    final key = store.state.searchState.key;
    if(key != ""){
      final pagination = store.state.searchState.users;
      if(!pagination.isLast && !pagination.hasAtLeastOnePage){
        store.dispatch(const GetFirstPageSearchingUsersAction());
      }
    }
  }
  next(action);
}
void getFirstPageSearchingUsersMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetFirstPageSearchingUsersAction){
    final key = store.state.searchState.key;
    UserService()
      .search(key, null, usersPerPage)
      .then((users){
        store.dispatch(AddFirstPageSearchingUsersAction(userIds: users.map((e) => e.id)));
        store.dispatch(AddUsersAction(users: users.map((e) => e.toUserState())));
        store.dispatch(AddUserImagesAction(images: users.map((e) => UserImageState.init(e.id))));
      });
  }
  next(action);
}
void getNextPageSearchingUsersIfReadyMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSearchingUsersIfReadyAction){
    final pagination = store.state.searchState.users;
    if(pagination.isReadyForNextPage){
      store.dispatch(const GetNextPageSearchingUsersAction());
    }
  }
  next(action);
}
void getNextPageSearchingUsersMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSearchingUsersAction){
    final key = store.state.searchState.key;
    final lastId = store.state.searchState.users.lastValue;
    UserService()
      .search(key, lastId, usersPerPage)
      .then((users){
        store.dispatch(AddUsersAction(users: users.map((e) => e.toUserState())));
        store.dispatch(AddUserImagesAction(images: users.map((e) => UserImageState.init(e.id))));
        store.dispatch(AddNextPageSearchingUsersAction(userIds: users.map((e) => e.id)));
      });
  }
  next(action);
}

void getFirstPageSearchingQuestionsIfNoPageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetFirstPageSearhingQuestionsIfNoPageAction){
    final pagination = store.state.searchState.questions;
    if(pagination.isReadyForNextPage && !pagination.hasAtLeastOnePage){
      store.dispatch(const GetFirstPageSearchingQuestionsAction());
    }
  }
  next(action);
}
void getFirstPageSearchingQuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetFirstPageSearchingQuestionsAction){
    final state = store.state.searchState;
    QuestionService()
      .searchQuestions(state.key, state.examId, state.subjectId, state.topicId, null, questionsPerPage)
      .then((questions){
        store.dispatch(AddFirstPageSearchingQuestionsAction(questionIds: questions.map((e) => e.id)));
        store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
        store.dispatch(AddQuestionImagesListAction(lists: questions.map((e) => e.images.map((e) => e.toQuestionImageState()))));
        store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
        store.dispatch(AddExamsAction(exams: questions.map((e) => e.exam.toExamState())));
        store.dispatch(AddSubjectsAction(subjects: questions.map((e) => e.subject.toSubjectState())));
        store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
      });
  }
  next(action);
}
void getNextPageSearchingQuestionsIfReadyMiddleare(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSearchingQuestionsIfReadyAction){
    final pagination = store.state.searchState.questions;
    if(pagination.isReadyForNextPage){
      store.dispatch(const GetNextPageSearchingQuestionsAction());
    }
  }
  next(action);
}
void getNextPageSearchingQuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSearchingQuestionsAction){
    final state = store.state.searchState;
    QuestionService()
      .searchQuestions(state.key, state.examId, state.subjectId, state.topicId, state.questions.lastValue, questionsPerPage)
      .then((questions){
        store.dispatch(AddNextPageSearchingQuestionsAction(questionIds: questions.map((e) => e.id)));
        store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
        store.dispatch(AddQuestionImagesListAction(lists: questions.map((e) => e.images.map((e) => e.toQuestionImageState()))));
        store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
        store.dispatch(AddExamsAction(exams: questions.map((e) => e.exam.toExamState())));
        store.dispatch(AddSubjectsAction(subjects: questions.map((e) => e.subject.toSubjectState())));
        store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
      });
  }
  next(action);
}