﻿using MySocailApp.Domain.AppUserAggregate;
using MySocailApp.Domain.ExamAggregate;
using MySocailApp.Domain.SubjectAggregate;

namespace MySocailApp.Domain.QuestionAggregate
{
    public class Question()
    {
        public int Id { get; private set; }
        public DateTime CreatedAt { get; private set; }
        public DateTime? Updatedat { get; private set; }
        public int ExamId { get; private set; }
        public int SubjectId { get; private set; }
        public int AppUserId { get; private set; }
        public string? Content { get; private set; }

        private readonly List<QuestionImage> _images = [];
        public IReadOnlyCollection<QuestionImage> Images => _images;
        public bool HasBlobName(string blobName) => _images.Any(x => x.BlobName == blobName);
        internal void AddImages(IEnumerable<string> blobNames) => _images.AddRange(blobNames.Select(QuestionImage.Create));

        private readonly List<QuestionTopic> _topics = [];
        public IReadOnlyCollection<QuestionTopic> Topics => _topics;
        internal void AddNewTopics(IEnumerable<int> topicIds)
        {
            _topics.Clear();
            _topics.AddRange(topicIds.Select(topicId => QuestionTopic.Create(Id, topicId)));
        }

        internal void Create(int appUserId, string? content, int examId, int subjectId)
        {
            AppUserId = appUserId;
            Content = content;
            ExamId = examId;
            SubjectId = subjectId;
            CreatedAt = DateTime.UtcNow;
        }

        public Exam Exam { get; }
        public Subject Subject { get; }
        public AppUser AppUser { get; }
    }
}