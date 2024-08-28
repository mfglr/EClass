import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/actions.dart' as redux;
import 'package:my_social_app/state/pagination/id_state.dart';

@immutable
class GetFirstPageSearchingUsersIfNoPageAction extends redux.Action{
  const GetFirstPageSearchingUsersIfNoPageAction();
}
@immutable
class GetFirstPageSearchingUsersAction extends redux.Action{
  const GetFirstPageSearchingUsersAction();
}
@immutable
class AddFirstPageSearchingUsersAction extends redux.Action{
  final Iterable<IdState> ids;
  const AddFirstPageSearchingUsersAction({required this.ids});
}
@immutable
class GetNextPageSearchingUsersIfReadyAction extends redux.Action{
  const GetNextPageSearchingUsersIfReadyAction();
}
@immutable
class GetNextPageSearchingUsersAction extends redux.Action{
  const GetNextPageSearchingUsersAction();
}
@immutable
class AddNextPageSearchingUsersAction extends redux.Action{
  final Iterable<IdState> ids;
  const AddNextPageSearchingUsersAction({required this.ids});
}

@immutable
class GetNextPageSearchedUsersIfNoPageAction extends redux.Action{
  const GetNextPageSearchedUsersIfNoPageAction();
}
@immutable
class GetNextPageSearchedUsersIfReadyAction extends redux.Action{
  const GetNextPageSearchedUsersIfReadyAction();
}
@immutable
class GetNextPageSearchedUsersAction extends redux.Action{
  const GetNextPageSearchedUsersAction();
}
@immutable
class AddNextPageSearchedUsersAction extends redux.Action{
  final Iterable<> userIds;
  const AddNextPageSearchedUsersAction({required this.userIds});
}
@immutable
class AddSearchedUserAction extends redux.Action{
  final int userId;
  const AddSearchedUserAction({required this.userId});
}
@immutable
class AddSearchedUserSuccessAction extends redux.Action{
  final int userId;
  const AddSearchedUserSuccessAction({required this.userId});
}
@immutable
class RemoveSearchedUserAction extends redux.Action{
  final int userId;
  const RemoveSearchedUserAction({required this.userId});
}
@immutable
class RemoveSearcedUserSuccessAction extends redux.Action{
  final int userId;
  const RemoveSearcedUserSuccessAction({required this.userId});
}

@immutable
class GetFirstPageSearhingQuestionsIfNoPageAction extends redux.Action{
  const GetFirstPageSearhingQuestionsIfNoPageAction();
}
@immutable
class GetFirstPageSearchingQuestionsAction extends redux.Action{
  const GetFirstPageSearchingQuestionsAction();
}
@immutable
class AddFirstPageSearchingQuestionsAction extends redux.Action{
  final Iterable<int> questionIds;
  const AddFirstPageSearchingQuestionsAction({required this.questionIds});
}
@immutable
class GetNextPageSearchingQuestionsIfReadyAction extends redux.Action{
  const GetNextPageSearchingQuestionsIfReadyAction();
}
@immutable
class GetNextPageSearchingQuestionsAction extends redux.Action{
  const GetNextPageSearchingQuestionsAction();
}
@immutable
class AddNextPageSearchingQuestionsAction extends redux.Action{
  final Iterable<int> questionIds;
  const AddNextPageSearchingQuestionsAction({required this.questionIds});
}

@immutable
class ChangeActivePageAction extends redux.Action{
  final int page;
  const ChangeActivePageAction({required this.page});
}
@immutable
class ChangeSearchKeyAction extends redux.Action{
  final String key;
  const ChangeSearchKeyAction({required this.key});
}
@immutable
class ChangeSearchExamIdAction extends redux.Action{
  final int examId;
  const ChangeSearchExamIdAction({required this.examId});
}
@immutable
class ChangeSearchSubjectIdAction extends redux.Action{
  final int subjectId;
  const ChangeSearchSubjectIdAction({required this.subjectId});
}
@immutable
class ChangeSearchTopicIdAction extends redux.Action{
  final int topicId;
  const ChangeSearchTopicIdAction({required this.topicId});
}
@immutable
class ClearKeyAction extends redux.Action{
  const ClearKeyAction();
}
