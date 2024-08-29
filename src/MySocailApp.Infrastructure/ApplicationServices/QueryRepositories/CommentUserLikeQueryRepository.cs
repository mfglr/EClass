﻿using Microsoft.EntityFrameworkCore;
using MySocailApp.Application.ApplicationServices.QueryRepositories;
using MySocailApp.Application.Queries.CommentAggregate;
using MySocailApp.Core;
using MySocailApp.Infrastructure.DbContexts;
using MySocailApp.Infrastructure.Extetions;
using MySocailApp.Infrastructure.Extetions.QueryableMappers;

namespace MySocailApp.Infrastructure.ApplicationServices.QueryRepositories
{
    public class CommentUserLikeQueryRepository(AppDbContext context) : ICommentUserLikeQueryRepository
    {
        private readonly AppDbContext _context = context;

        public Task<List<CommentUserLikeResponseDto>> GetLikesAsync(int commentId, int accountId, IPage page, CancellationToken cancellationToken)
            => _context.CommentUserLikes
                .AsNoTracking()
                .Where(x => x.CommentId == commentId)
                .ToPage(page)
                .ToCommentUserLikeResponseDto(accountId)
                .ToListAsync(cancellationToken);
                
                
    }
}