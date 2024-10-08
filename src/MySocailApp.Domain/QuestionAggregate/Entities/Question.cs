﻿using MySocailApp.Core;
using MySocailApp.Domain.AppUserAggregate.Entities;
using MySocailApp.Domain.CommentAggregate.Entities;
using MySocailApp.Domain.ExamAggregate.Entitities;
using MySocailApp.Domain.NotificationAggregate.Entities;
using MySocailApp.Domain.QuestionAggregate.DomainEvents;
using MySocailApp.Domain.QuestionAggregate.Excpetions;
using MySocailApp.Domain.QuestionAggregate.ValueObjects;
using MySocailApp.Domain.SolutionAggregate.Entities;
using MySocailApp.Domain.SubjectAggregate.Entities;

namespace MySocailApp.Domain.QuestionAggregate.Entities
{
    public class Question() : Entity, IAggregateRoot
    {
        public readonly static int MaxTopicCountPerQuestion = 3;
        public readonly static int MaxImageCountPerQuestion = 3;

        public int ExamId { get; private set; }
        public int SubjectId { get; private set; }
        public int AppUserId { get; private set; }
        public QuestionContent Content { get; private set; }

        private readonly List<QuestionImage> _images = [];
        public IReadOnlyCollection<QuestionImage> Images => _images;
        public bool HasBlobName(string blobName) => _images.Any(x => x.BlobName == blobName);

        private readonly List<QuestionTopic> _topics = [];
        public IReadOnlyCollection<QuestionTopic> Topics => _topics;
        internal void AddNewTopics(IEnumerable<int> topics)
        {
            if (topics.Count() > MaxTopicCountPerQuestion)
                throw new TooManyTopicsException();
            _topics.Clear();
            _topics.AddRange(topics.Select(topicId => QuestionTopic.Create(topicId)));
        }

        internal void Create(int appUserId, QuestionContent content, int examId, int subjectId, IEnumerable<int> topics, IEnumerable<QuestionImage> images)
        {
            if (topics.Count() > MaxTopicCountPerQuestion)
                throw new TooManyTopicsException();
            if (!images.Any())
                throw new QuestionImageIsRequiredException();
            if (images.Count() > MaxImageCountPerQuestion)
                throw new TooManyQuestionImagesException();

            AppUserId = appUserId;
            Content = content;
            ExamId = examId;
            SubjectId = subjectId;
            CreatedAt = DateTime.UtcNow;
            _topics.AddRange(topics.Select(topicId => QuestionTopic.Create(topicId)));
            _images.AddRange(images);
        }

        public bool IsRemoved { get; private set; }
        public void Remove()
        {
            IsRemoved = true;
            AddDomainEvent(new QuestionDeletedDomainEvent(this));
        }

        private readonly List<QuestionUserLike> _likes = [];
        public IReadOnlyList<QuestionUserLike> Likes => _likes;
        private readonly List<QuestionLikeNotification> _likeNotifications = [];
        public IReadOnlyList<QuestionLikeNotification> LikeNotifications => _likeNotifications;
        public QuestionUserLike Like(int likerId)
        {
            if (_likes.Any(x => x.AppUserId == likerId))
                throw new QuestionWasAlreadyLikedException();

            var like = QuestionUserLike.Create(likerId);
            _likes.Add(like);
            if (likerId != AppUserId && !_likeNotifications.Any(x => x.AppUserId == likerId))
            {
                _likeNotifications.Add(new QuestionLikeNotification(likerId));
                AddDomainEvent(new QuestionLikedDomainEvent(this, like));
            }
            return like;
        }
        public void Dislike(int userId)
        {
            var index = _likes.FindIndex(x => x.AppUserId == userId);
            if (index == -1)
                return;
            _likes.RemoveAt(index);
            AddDomainEvent(new QuestionDislikedDomainEvent(this));
        }

        //saving questions
        private readonly List<QuestionUserSave> _savers = [];
        public IReadOnlyList<QuestionUserSave> Savers => _savers;
        public QuestionUserSave Save(int appUserId)
        {
            if (_savers.Any(x => x.AppUserId == appUserId))
                throw new QuestionAlreadySavedException();
            var save = QuestionUserSave.Create(appUserId);
            _savers.Add(save);
            return save;
        }
        public void Unsave(int appUserId)
        {
            var save = _savers.FirstOrDefault(x => x.AppUserId == appUserId) ?? throw new QuestionNotSavedException();
            _savers.Remove(save);
        }

        // Readonly navigator properties
        public Exam Exam { get; } = null!;
        public Subject Subject { get; } = null!;
        public AppUser AppUser { get; } = null!;
        public IReadOnlyList<Solution> Solutions { get; } = null!;
        public IReadOnlyCollection<Comment> Comments { get; } = null!;
        public IReadOnlyCollection<Notification> Notifications { get; } = null!;
    }
}
