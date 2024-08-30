﻿using MySocailApp.Application.Queries.SolutionAggregate;
using MySocailApp.Domain.SolutionAggregate.Entities;
using MySocailApp.Domain.SolutionAggregate.ValueObjects;

namespace MySocailApp.Infrastructure.Extetions.QueryableMappers
{
    public static class SolutionQueryableMappers
    {
        public static IQueryable<SolutionResponseDto> ToSolutionResponseDto(this IQueryable<Solution> query,int accountId)
            => query
                .Select(
                    x => new SolutionResponseDto(
                        x.Id,
                        x.CreatedAt,
                        x.UpdatedAt,
                        x.QuestionId,
                        x.AppUser.Account.UserName!,
                        x.AppUserId,
                        x.Content != null ? x.Content.Value : null,
                        x.Votes.Any(v => v.AppUserId == accountId && v.Type == SolutionVoteType.Upvote),
                        x.Votes.Count,
                        x.Votes.Any(v => v.AppUserId == accountId && v.Type == SolutionVoteType.Downvote),
                        x.Votes.Count,
                        x.Comments.Count,
                        x.State,
                        x.Question.AppUserId == accountId,
                        x.Images.Select(
                            i => new SolutionImageResponseDto(
                                i.Id,
                                i.SolutionId,
                                i.BlobName,
                                i.Height,
                                i.Width
                            )
                        )
                    )
                );
    }
}
