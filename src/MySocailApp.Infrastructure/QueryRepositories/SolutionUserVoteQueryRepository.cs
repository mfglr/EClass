﻿using Microsoft.EntityFrameworkCore;
using MySocailApp.Application.Queries.SolutionAggregate;
using MySocailApp.Application.QueryRepositories;
using MySocailApp.Core;
using MySocailApp.Domain.SolutionAggregate.ValueObjects;
using MySocailApp.Infrastructure.DbContexts;
using MySocailApp.Infrastructure.Extetions;
using MySocailApp.Infrastructure.QueryRepositories.QueryableMappers;

namespace MySocailApp.Infrastructure.QueryRepositories
{
    public class SolutionUserVoteQueryRepository(AppDbContext context) : ISolutionUserVoteQueryRepository
    {
        private readonly AppDbContext _context = context;

        public Task<List<SolutionUserVoteResponseDto>> GetSolutionUpvotes(int accountId, IPage page, int solutionId, CancellationToken cancellationToken)
            => _context.SolutionUserVotes
                .AsNoTracking()
                .Where(x => x.SolutionId == solutionId && x.Type == SolutionVoteType.Upvote)
                .ToPage(page)
                .ToSolutionUserVoteDto(accountId)
                .ToListAsync(cancellationToken);

        public Task<List<SolutionUserVoteResponseDto>> GetSolutionDownvotes(int accountId, IPage page, int solutionId, CancellationToken cancellationToken)
            => _context.SolutionUserVotes
                .AsNoTracking()
                .Where(x => x.SolutionId == solutionId && x.Type == SolutionVoteType.Downvote)
                .ToPage(page)
                .ToSolutionUserVoteDto(accountId)
                .ToListAsync(cancellationToken);
    }
}
