﻿using MediatR;

namespace MySocailApp.Application.Commands.UserAggregate.Unfollow
{
    public record UnfollowDto(int FollowedId) : IRequest;
}
