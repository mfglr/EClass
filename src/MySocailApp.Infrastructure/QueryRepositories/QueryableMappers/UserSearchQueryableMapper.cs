﻿using MySocailApp.Application.Queries.UserAggregate;
using MySocailApp.Domain.AppUserAggregate.Entities;

namespace MySocailApp.Infrastructure.QueryRepositories.QueryableMappers
{
    public static class UserSearchQueryableMapper
    {
        public static IQueryable<UserSearchResponseDto> ToUserSearchedResponseDto(this IQueryable<UserSearch> query, int accountId)
            => query
                .Select(
                    x => new UserSearchResponseDto(
                        x.Id,
                        x.SearcherId,
                        x.SearchedId,
                        x.CreatedAt,
                        null,
                        new AppUserResponseDto(
                            x.Searched.Id,
                            x.Searched.CreatedAt,
                            x.Searched.UpdatedAt,
                            x.Searched.Account.UserName!,
                            x.Searched.Name,
                            x.Searched.Biography.Value,
                            x.Searched.HasImage,
                            x.Searched.Questions.Count,
                            x.Searched.Followers.Count,
                            x.Searched.Followeds.Count,
                            x.Searched.Followeds.Any(x => x.FollowedId == accountId),
                            x.Searched.Followers.Any(x => x.FollowerId == accountId)
                        )
                    )
                );
    }
}
