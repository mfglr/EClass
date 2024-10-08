﻿using MySocailApp.Core;
using MySocailApp.Domain.AppUserAggregate.Entities;
using MySocailApp.Domain.CommentAggregate.Entities;
using MySocailApp.Domain.NotificationAggregate.Entities;
using MySocailApp.Domain.QuestionAggregate.Entities;
using MySocailApp.Domain.SolutionAggregate.DomainEvents;
using MySocailApp.Domain.SolutionAggregate.Exceptions;
using MySocailApp.Domain.SolutionAggregate.ValueObjects;

namespace MySocailApp.Domain.SolutionAggregate.Entities
{
    public class Solution : Entity, IAggregateRoot
    {
        public int QuestionId { get; private set; }
        public int AppUserId { get; private set; }
        public SolutionContent Content { get; private set; } = null!;
        private readonly List<SolutionImage> _images = [];
        public IReadOnlyCollection<SolutionImage> Images => _images;
        public SolutionVideo? Video { get; private set; }

        private Solution() { }

        public Solution(SolutionContent content, IEnumerable<SolutionImage> images)
        {
            if ((content == null || content.Value.Trim() == "") && !images.Any())
                throw new SolutionContentRequiredException();
            if (images.Count() > 3)
                throw new TooManySolutionImageException();
            
            ArgumentNullException.ThrowIfNull(content);

            Content = content;
            _images.AddRange(images);
            State = SolutionState.Pending;
        }

        public Solution(SolutionContent content,SolutionVideo video)
        {
            ArgumentNullException.ThrowIfNull(content);
            ArgumentNullException.ThrowIfNull(video);

            Content = content;
            Video = video;
            _images.Add(SolutionImage.Create(video.FrameBlobName,video.FrameHeight,video.FrameWidth));
            State = SolutionState.Pending;
        }

        internal void Create(int questionId, int appUserId)
        {
            QuestionId = questionId;
            AppUserId = appUserId;
            UpdatedAt = CreatedAt = DateTime.UtcNow;
            AddDomainEvent(new SolutionCreatedDomainEvent(this));
        }

        public bool IsRemoved { get; private set; }
        public void Remove()
        {
            IsRemoved = true;
            AddDomainEvent(new SolutionDeletedDomainEvent(this));
        }

        private readonly List<SolutionUserVote> _votes = [];
        public IReadOnlyCollection<SolutionUserVote> Votes => _votes;
        private readonly List<SolutionVoteNotification> _voteNotifications = [];
        public IReadOnlyCollection<SolutionVoteNotification> VoteNotifications => _voteNotifications;
        public SolutionUserVote MakeUpvote(int voterId)
        {
            var index = _votes.FindIndex(x => x.AppUserId == voterId);
            if (index != -1)
            {
                if (_votes[index].Type == SolutionVoteType.Upvote)
                    throw new SolutionUpvotedBeforeException();
                _votes.RemoveAt(index);//Remove downvote
                AddDomainEvent(new SolutionDownvoteRemovedDomainEvent(this));
            }
            
            var vote = SolutionUserVote.GenerateUpvote(voterId);
            _votes.Add(vote);

            if(AppUserId != voterId && !_voteNotifications.Any(x => x.AppUserId == voterId))
            {
                _voteNotifications.Add(new SolutionVoteNotification(voterId));
                AddDomainEvent(new SolutionWasUpvotedDomainEvent(this, vote));
            }
            return vote;
        }
        public SolutionUserVote MakeDownvote(int voterId)
        {
            var index = _votes.FindIndex(x => x.AppUserId == voterId);
            if (index != -1)
            {
                if (_votes[index].Type == SolutionVoteType.Downvote)
                    throw new SolutionDownvotedBeforeException();
                _votes.RemoveAt(index);//Remove upvote
                AddDomainEvent(new SolutionUpvoteRemovedDomainEvent(this));
            }
            
            var vote = SolutionUserVote.GenerateDownvote(voterId);
            _votes.Add(vote);

            if(AppUserId != voterId && !_voteNotifications.Any(x => x.AppUserId == voterId))
            {
                _voteNotifications.Add(new SolutionVoteNotification(voterId));
                AddDomainEvent(new SolutionWasDownvotedDomainEvent(this, vote));
            }
            return vote;
        }
        public void RemoveUpvote(int voterId)
        {
            int index = _votes.FindIndex(x => x.AppUserId == voterId);
            if (index == -1 || _votes[index].Type == SolutionVoteType.Downvote)
                throw new VoteIsNotFoundException();
            _votes.RemoveAt(index);
            AddDomainEvent(new SolutionUpvoteRemovedDomainEvent(this));
        }
        public void RemoveDownvote(int voterId)
        {
            int index = _votes.FindIndex(x => x.AppUserId == voterId);
            if(index == -1 || _votes[index].Type == SolutionVoteType.Upvote)
                throw new VoteIsNotFoundException();
            _votes.RemoveAt(index);
            AddDomainEvent(new SolutionDownvoteRemovedDomainEvent(this));
        }

        public SolutionState State { get; private set; }
        internal void MarkAsCorrect()
        {
            if (State != SolutionState.Pending)
                throw new InvalidStateTransitionException();

            State = SolutionState.Correct;
            UpdatedAt = DateTime.UtcNow;
            AddDomainEvent(new SolutionMarkedAsCorrectDomainEvent(this));
        }
        internal void MarkAsIncorrect()
        {
            if (State != SolutionState.Pending)
                throw new InvalidStateTransitionException();
            State = SolutionState.Incorrect;
            UpdatedAt = DateTime.UtcNow;
            AddDomainEvent(new SolutionMarkedAsIncorrectDomainEvent(this));
        }

        private readonly List<SolutionUserSave> _savers = [];
        public IReadOnlyCollection<SolutionUserSave> Savers => _savers;
        public SolutionUserSave Save(int saverId)
        {
            if (_savers.Any(x => x.AppUserId == saverId))
                throw new SolutionAlreadySavedException();
            var save = SolutionUserSave.Create(saverId);
            _savers.Add(save);
            return save;
        }
        public void Unsave(int saverId)
        {
            var index = _savers.FindIndex(x => x.AppUserId == saverId);
            if (index == -1) return;
            _savers.RemoveAt(index);
        }

        //Readonly navigator properties
        public Question Question { get; } = null!;
        public AppUser AppUser { get; } = null!;
        public IReadOnlyList<Comment> Comments { get; } = null!;
        public IReadOnlyCollection<Notification> Notifications { get; } = null!;
    }
}
