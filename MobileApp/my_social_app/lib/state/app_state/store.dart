import 'dart:ui';
import 'package:my_social_app/constants/record_per_page.dart';
import 'package:my_social_app/state/app_state/account_state/middlewares.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/comment_entity_state.dart';
import 'package:my_social_app/state/app_state/comment_user_like_state/comment_user_like_entity_state.dart';
import 'package:my_social_app/state/app_state/create_comment_state/create_comment_state.dart';
import 'package:my_social_app/state/app_state/create_comment_state/middlewares.dart';
import 'package:my_social_app/state/app_state/create_message_state/create_message_state.dart';
import 'package:my_social_app/state/app_state/create_message_state/middlewares.dart';
import 'package:my_social_app/state/app_state/exam_entity_state/exam_entity_state.dart';
import 'package:my_social_app/state/app_state/exam_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/follow_entity_state/follow_entity_state.dart';
import 'package:my_social_app/state/app_state/home_page_state/home_page_state.dart';
import 'package:my_social_app/state/app_state/home_page_state/middlewares.dart';
import 'package:my_social_app/state/app_state/login_state/login_state.dart';
import 'package:my_social_app/state/app_state/message_entity_state/message_entity_state.dart';
import 'package:my_social_app/state/app_state/message_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/message_home_page_state/message_home_page_state.dart';
import 'package:my_social_app/state/app_state/message_home_page_state/middlewares.dart';
import 'package:my_social_app/state/app_state/message_image_entity_state/message_image_entity_state.dart';
import 'package:my_social_app/state/app_state/message_image_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/middlewares.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/notification_entity_state.dart/middlewares.dart';
import 'package:my_social_app/state/app_state/notification_entity_state.dart/notification_entity_state.dart';
import 'package:my_social_app/state/app_state/policy_state/middlewares.dart';
import 'package:my_social_app/state/app_state/policy_state/policy_state.dart';
import 'package:my_social_app/state/app_state/question_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/question_entity_state/question_entity_state.dart';
import 'package:my_social_app/state/app_state/question_user_like_state/question_user_like_entity_state.dart';
import 'package:my_social_app/state/app_state/question_user_save_state/question_user_save_entity_state.dart';
import 'package:my_social_app/state/app_state/reducer.dart';
import 'package:my_social_app/state/app_state/search_state/middlewares.dart';
import 'package:my_social_app/state/app_state/search_state/search_state.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/solution_entity_state.dart';
import 'package:my_social_app/state/app_state/solution_user_save_entity_state/solution_user_save_entity_state.dart';
import 'package:my_social_app/state/app_state/solution_user_vote_entity_state/solution_user_vote_entity_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/subject_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/subject_entity_state/subject_entity_state.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/topic_entity_state.dart';
import 'package:my_social_app/state/app_state/user_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/user_entity_state/user_entity_state.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/user_image_entity_state.dart';
import 'package:my_social_app/state/app_state/user_search_state/user_search_entity_state.dart';
import 'package:my_social_app/state/pagination/entity_pagination.dart';
import 'package:my_social_app/state/pagination/pagination.dart';
import 'package:redux/redux.dart';

final store = Store(
  reducers,
  initialState: AppState(
    accessToken: null,
    accountState: null,
    isInitialized: false,
    userEntityState: const UserEntityState(entities: {}),
    userImageEntityState: const UserImageEntityState(entities: {}),
    searchState: SearchState(
      key: "",examId: null,subjectId: null,topicId: null,
      questions: Pagination.init(questionsPerPage,true),
      users: Pagination.init(usersPerPage,true),
      searchedUsers: Pagination.init(usersPerPage,true)
    ),
    examEntityState: const ExamEntityState(entities: {}),
    subjectEntityState: const SubjectEntityState(entities: {}),
    topicEntityState: const TopicEntityState(entities: {}),
    solutionEntityState: const SolutionEntityState(entities: {}),
    homePageState: HomePageState(questions: Pagination.init(questionsPerPage,true)),
    commentEntityState: const CommentEntityState(entities: {}),
    commentUserLikeEntityState: const CommentUserLikeEntityState(entities: {}),
    createCommentState: const CreateCommentState(question: null, solution: null, comment: null, content: ""),
    notificationEntityState: NotificationEntityState(pagination: EntityPagination.init(notificationsPerPage, true)),
    messageEntityState: const MessageEntityState(entities: {}),
    messageImageEntityState: const MessageImageEntityState(entities: {}),
    messageHomePageState: MessageHomePageState(conversations: Pagination.init(conversationsPerPage,true)),
    createMessageState: const CreateMessageState(content: null, images: [], receiverId: null),
    userSearchEntityState: const UserSearchEntityState(entities: {}),
    followEntityState: const FollowEntityState(entities: {}),
    questionEntityState: const QuestionEntityState(entities: {}),
    questionUserLikeEntityState: const QuestionUserLikeEntityState(entities: {}),
    questionUserSaveEntityState: const QuestionUserSaveEntityState(entities: {}),
    solutionUserVoteEntityState: const SolutionUserVoteEntityState(entities: {}),
    solutionUserSaveEntityState: const SolutionUserSaveEntityState(entities: {}),
    exams: Pagination.init(examsPerPage, true),
    policyState: const PolicyState(privacyPolicies: {}, termOfUses: {}),
    loginState: LoginState(activeLoginPage: ActiveLoginPage.loginPage, language: PlatformDispatcher.instance.locale.languageCode)
  ),
  middleware: [
    //exams middlewares
    getNextPageExamsIfNoPageMiddleware,
    getNextPageExamsIfReadyMiddleware,
    getNextPageExamsMidleware,
    //

    //Comment entity state middleware
    getNextPageCommentLikesIfNoPageMiddleware,
    getNextPageCommentLikesIfReadyActionMiddleware,
    getNextPageCommentLikesMiddleware,
    likeCommentMiddleware,
    dislikeCommentMiddleware,
    
    getNextPageCommentRepliesMiddleware,
    getNextPageCommentRepliesIfNoPageMiddleware,
    getNextPageCommentRepliesIfReadyMiddleware,

    //Home page state
    getNextPageHomeQuestionsIfNoPageMiddleware,
    getNextPageHomeQuestionsIfReadyMiddleware,
    getNextPageHomeQuestionsMiddleware,
    getPrevPageHomeQuestionsMiddleware,
    getPrevPageHomePageQuestionsIfReadyMiddleware,
    
    //account start
    loginByRefreshTokenMiddleware,
    confirmEmailMiddleware,
    updateLanguageMiddleware,
    loginByPaswordMiddleware,
    loginByFaceBookMiddleware,
    loginByGoogleMiddleware,
    createAccountMiddleware,
    deleteAccountMiddleware,
    approvePrivacyPolicyMiddleware,
    approveTersmOfUseMiddleware,
    logOutMiddleware,
    //account end

    //user entity state
    loadUserMiddleware,
    loadUserByUserNameMiddleware,

    followMiddleware,
    unfollowMiddleware,
    removeFollowerMiddleware,

    getNextPageUserFollowersIfNoPageMiddleware,
    getNextPageUserFollowersIfReadyMiddleware,
    getNextPageUserFollowersMiddleware,

    getNextPageUserFollowedsIfNoPageMiddleware,
    getNextPageUserFollowedsIfReadyMiddleware,
    getNextPageUserFollowedsMiddleware,

    getNextPageUserNotFollowedsIfNoPageMiddleware,
    getNextPageUserNotFollowedsIfReadyMiddleware,
    getNextPageUserNotFollowedsMiddleware,

    getNextPageUserMessageIfNoPageMiddleware,
    getNextPageUserMessageIfReadyMiddleware,
    getNextPageUserMessagesMiddleware,

    getNextPageUserQuestionsIfNoPageMiddleware,
    getNextPageUserQuestionsIfReadyMiddleware,
    nextPageOfUserQuestionsMiddleware,

    getNextPageUserSolvedQuestionsIfNoPageMiddleware,
    getNextPageUserSolvedQuestionsIfReadyMiddleware,
    getNextPageUserSolvedQuestionsMiddleware,

    getNextPageUserUnsolvedQuestionsIfNoPageMiddleware,
    getNextPageUserUnsolvedQuestionsIfReadyMiddleware,
    getNextPageUserUnsolvedQuestionsMiddleware,

    getNextPageUserSavedQuestionsIfNoPageMiddleware,
    getNextPageUserSavedQuestionsIfReadyMiddleware,
    getNextPageUserSavedQuestionsMiddleware,

    getNextPageUserSavedSolutionsIfNoPageMiddleaware,
    getNextPageUserSavedSolutionsIfReadyMiddleaware,
    getNextPageUserSavedSolutionsMiddleware,
    
    getNextPageUserConversationsMiddlewareIfNoPageAction,
    getNextPageUserConversationsMiddlewareIfReadyAction,
    getNextPageUserConvesationsMiddleware,

    updateUserNameMiddleware,
    updateNameMiddleware,
    updateBiographyMidleware,
    //user end

    //user image start
    loadUserImageMiddleware,
    updateCurrentUserImageMiddleware,
    removeCurrentUserImageMiddleware,
    //user imgage end

    //search state
    getFirstPageSearchingUsersIfNoPageMiddleware,
    getFirstPageSearchingUsersMiddleware,
    getNextPageSearchingUsersIfReadyMiddleware,
    getNextPageSearchingUsersMiddleware,

    getNextPageSearchedUsersIfNoPageMiddleware,
    getNextPageSearchedUsersIfReadyMiddleware,
    getNextPageSearchedUsersMiddleware,
    addSearchedUserMiddleware,
    removeSearchedUserMiddleware,
    
    getFirstPageSearchingQuestionsIfNoPageMiddleware,
    getFirstPageSearchingQuestionsMiddleware,
    getNextPageSearchingQuestionsIfReadyMiddleare,
    getNextPageSearchingQuestionsMiddleware,
    //search end
    
    //Exam entity state
    getNextPageExamSubjectsIfNoPageMiddleware,
    getNextPageExamSubjectsMiddleware,

    getNextPageExamQeuestionsMiddleware,
    getNextPageOfExamQuestionsIfNoPageMiddleware,
    getNextPageExamQuestionsIfReadyMiddleware,

    getPrevPageExamQuestionsIfReadyMiddleware,
    getPrevPageExamQuestionsMiddleware,

    //subject entity state
    getNextPageSubjectQuestionsIfNoPageMiddleware,
    getNextPageSubjectQuestionsIfReadyMiddleware,
    getNextPageSubjectQuestionsMiddleware,

    getPrevPageSubjectQuestionsIfReadyMiddleware,
    getPrevPageSubjectQuestionsMiddleware,

    getSubjectTopicsIfNoPageMiddleware,
    getSubjectTopicsMiddleware,

    //Topic start
    getNextPageTopicQuestionsMiddleware,
    getNextPageTopicQuestionsIfNoPageMiddleware,
    getNextPageTopicQuestionsIfReadyMiddeware,

    getPrevPageTopicQuestionsIfReadyMiddleware,
    getPrevPageTopicQuestionsMiddleware,
    //Topic end

    // Questions entity state
    loadQuestionMiddleware,
    createQuestionMiddleware,
    deleteQuestionMiddleware,
    saveQuestionMiddleware,
    unsaveQuestionMiddleware,

    likeQuestionMiddleware,
    dislikeQuestionMiddleware,
    getNextPageQuestionLikesIfNoPageMiddleware,
    getNextPageQuestionLikesIfReadyMiddleware,
    getNextPageQuestionLikesMiddleware,

    getNextPageQuestionSolutionIfNoPageMiddleware,
    getNextPageQuestionSolutionsIfReadyMiddleware,
    getNextPageQuestionSolutionsMiddleware,

    getNextPageQuestionCorrectSolutionsIfNoPageMiddleware,
    getNextPageQuestionCorrectSolutionsIfReadyMiddleware,
    getNextPageQuestionCorrectSolutionsMiddleware,
    
    getNextPageQuestionPendingSolutionsIfNoPageMiddleware,
    getNextPageQuestionPendingSolutionsIfReadMiddleware,
    getNextPageQuestionPendingSolutionsMiddleware,

    getNextPageQuestionIncorrectSolutionsIfNoPageMiddleware,
    getNextPageQuestionIncorrectSolutionsIfReadyMiddleware,
    getNextPageQuestionIncorrectSolutionsMiddleware,

    getNextPageQuestionVideoSolutionsIfNoPageMiddleware,
    getNextPageQuestionVideoSolutionsIfReadyMiddleware,
    getNextPageQuestionVideoSolutionsMiddleware,

    getNextPageQuestionCommentsIfNoPageCommentsMiddleware,
    getNextPageQuestionCommentIfReadyMiddleware,
    getNextPageQuestionCommentsMiddleware,
   
    loadQuestionImageMiddleware,
    

    //solution entity state
    createSolutionMiddleware,
    createVideoSolutionMiddleware,
    loadSolutionMiddleware,
    removeSolutionMiddleware,

    getNextPageSolutionUpvotesIfNoPageMiddleware,
    getNextPageSolutionUpvotesIfReadyMiddleware,
    getNextPageSolutionUpvotesMiddleware,
    makeSolutionUpvoteMiddleware,
    removeSolutionUpvoteMiddleware,

    getNextSolutionPageDownvotesIfNoPageMiddleware,
    getNextPageSolutionDownvotesIfReady,
    getNextPageDownvotesMiddleware,
    makeSolutionDownvoteMiddleware,
    removeSolutionDownvoteMiddleware,
   
    getNextPageSolutionCommentsIfNoPageMiddleware,
    getNextPageSolutionCommentsIfReadyMiddleware,
    getNextPageSolutionCommentsMiddleware,
    loadSolutionImageMiddleware,
    
    markSolutionAsCorrectMiddleware,
    markSolutionAsIncorrectMiddleware,

    saveSolutionMiddleware,
    unsaveSolutionMiddleware,
    //solution end

    //comments entity state
    createCommentMiddleware,
    loadCommentMiddleware,
    loadCommentsMiddleware,
    removeCommentMiddleware,

    //notifications start
    markNotificationsAsViewedMiddleware,
    getUnviewedNotificationMiddleware,
    getNextPageNotificationsIfNoPageMiddeware,
    getNextPageNotificationsIfReadyActionMiddleware,
    getNextPageNotificationsMiddleware,
    //notifications end

    //conversations start
    getNextPageConversationsMiddleware,
    getNextPageConversationsIfNoPageMiddleware,
    getNextPageConversationsIfReadyActionMiddleware,
    //conversations end

    //message
    markComingMessageAsReceivedMiddleware,
    markComingMessageAsViewedMiddleware,
    markComingMessagesAsReceivedMiddleware,
    markComingMessagesAsViewedMiddleware,
    createMessageWithImagesMiddleware,
    createMessageMiddleware,
    getUnviewedMessagesMiddleware,
    loadMessageMiddleware,
    removeMessageMiddleware,
    removeMessagesMiddleware,
    removeMessagesByUserIdsMiddleware,

    //message image
    loadMessageImageMiddleware,


    //policyState
    loadPrivacyPolicyMiddleware,
    loadTermsOfUseMiddleware,

  ]
);