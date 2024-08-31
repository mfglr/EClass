﻿using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using MySocailApp.Application.Queries.QuestionAggregate;
using MySocailApp.Application.QueryRepositories;
using MySocailApp.Core;
using MySocailApp.Domain.AccountAggregate.Entities;
using MySocailApp.Domain.ExamAggregate.Entitities;
using MySocailApp.Domain.QuestionAggregate.Entities;
using MySocailApp.Domain.SolutionAggregate.ValueObjects;
using MySocailApp.Infrastructure.DbContexts;
using MySocailApp.Infrastructure.Extetions;
using MySocailApp.Infrastructure.QueryRepositories.QueryableMappers;
using System.Linq.Expressions;

namespace MySocailApp.Infrastructure.QueryRepositories
{
    public class QuestionQueryRepository(AppDbContext context) : IQuestionQueryRepository
    {
        private readonly AppDbContext _context = context;

        private Task<QuestionResponseDto?> GetFirstAsync(int accountId, Expression<Func<Question, bool>> predicate, CancellationToken cancellationToken)
            => _context.Questions
                .AsNoTracking()
                .Where(predicate)
                .ToQuestionResponseDto(accountId)
                .FirstOrDefaultAsync(cancellationToken);

        private Task<List<QuestionResponseDto>> GetListAsync(int accountId, IPage page, Expression<Func<Question, bool>> predicate, CancellationToken cancellationToken)
            => _context.Questions
                .AsNoTracking()
                .Where(predicate)
                .ToPage(page)
                .ToQuestionResponseDto(accountId)
                .ToListAsync(cancellationToken);

        public Task<QuestionResponseDto?> GetQuestionByIdAsync(int id, int accountId, CancellationToken cancellationToken)
            => GetFirstAsync(accountId, x => x.Id == id, cancellationToken);
        public Task<List<QuestionResponseDto>> GetHomePageQuestionsAsync(int accountId, IPage page, CancellationToken cancellationToken)
            => GetListAsync(accountId, page, x => x.AppUserId != accountId, cancellationToken);
        public Task<List<QuestionResponseDto>> GetUserQuestionsAsync(int userId, int accountId, IPage page, CancellationToken cancellationToken)
            => GetListAsync(accountId, page, x => x.AppUserId == userId, cancellationToken);
        public Task<List<QuestionResponseDto>> GetTopicQuestionsAsync(int topicId, int accountId, IPage page, CancellationToken cancellationToken)
            => GetListAsync(accountId, page, x => x.Topics.Any(x => x.TopicId == topicId), cancellationToken);
        public Task<List<QuestionResponseDto>> GetSubjectQuestionsAsync(int subjectId, int accountId, IPage page, CancellationToken cancellationToken)
            => GetListAsync(accountId, page, x => x.SubjectId == subjectId, cancellationToken);
        public Task<List<QuestionResponseDto>> GetExamQuestionsAsync(int examId, int accountId, IPage page, CancellationToken cancellationToken)
            => GetListAsync(accountId, page, x => x.ExamId == examId, cancellationToken);
        public Task<List<QuestionResponseDto>> SearchQuestionsAsync(int accountId, IPage page, string? key, int? examId, int? subjectId, int? topicId, CancellationToken cancellationToken)
            => GetListAsync(
                accountId,
                page,
                x =>
                    (key == null || x.Content != null && x.Content.ToLower().Contains(key.ToLower())) &&
                    (examId == null || x.ExamId == examId) &&
                    (subjectId == null || x.SubjectId == subjectId) &&
                    (topicId == null || x.Topics.Any(x => x.TopicId == topicId)),
                cancellationToken
            );
        public Task<List<QuestionResponseDto>> GetSolvedQuestionsByUserIdAsync(int accountId, IPage page, int userId, CancellationToken cancellationToken)
            => GetListAsync(accountId, page, x => x.AppUserId == userId && x.Solutions.Any(x => x.State == SolutionState.Correct), cancellationToken);
        public Task<List<QuestionResponseDto>> GetUnsolvedQuestionsByUserIdAsync(int accountId, IPage page, int userId, CancellationToken cancellationToken)
           => GetListAsync(accountId, page, x => x.AppUserId == userId && !x.Solutions.Any(x => x.State == SolutionState.Correct), cancellationToken);
    }
}