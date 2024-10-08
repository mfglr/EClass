﻿namespace MySocailApp.Domain.NotificationAggregate.ValueObjects
{
    public enum NotificationType
    {
        QuestionCommentCreatedNotification,
        SolutionCommentCreatedNotification,
        CommentRepliedNotification,
        QuestionLikedNotification,
        CommentLikedNotification,
        SolutionCreatedNotification,
        UserTaggedCommentNotification,
        UserFollowedNotification,
        SolutionMarkedAdIncorrect,
        SolutionMarkedAsCorrect,
        QuestionSolvedNotification,
        SolutionWasUpvotedNotification,
        SolutionWasDownvotedNotification
    }
}
