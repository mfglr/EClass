﻿using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySocailApp.Api.Filters;
using MySocailApp.Application.Commands.UserAggregate.AcceptFollowRequest;
using MySocailApp.Application.Commands.UserAggregate.Block;
using MySocailApp.Application.Commands.UserAggregate.CancelFollowRequest;
using MySocailApp.Application.Commands.UserAggregate.MakeFollowRequest;
using MySocailApp.Application.Commands.UserAggregate.MakeProfilePrivate;
using MySocailApp.Application.Commands.UserAggregate.MakeProfilePublic;
using MySocailApp.Application.Commands.UserAggregate.RejectFollowRequest;
using MySocailApp.Application.Commands.UserAggregate.RemoveFollower;
using MySocailApp.Application.Commands.UserAggregate.RemoveUserImage;
using MySocailApp.Application.Commands.UserAggregate.Unblock;
using MySocailApp.Application.Commands.UserAggregate.UpdateBirthDate;
using MySocailApp.Application.Commands.UserAggregate.UpdateGender;
using MySocailApp.Application.Commands.UserAggregate.UpdateName;
using MySocailApp.Application.Commands.UserAggregate.UpdateUserImage;
using MySocailApp.Application.Queries.UserAggregate;
using MySocailApp.Application.Queries.UserAggregate.GetFollowedsById;
using MySocailApp.Application.Queries.UserAggregate.GetFollowersById;
using MySocailApp.Application.Queries.UserAggregate.GetNotFolloweds;
using MySocailApp.Application.Queries.UserAggregate.GetRequesteds;
using MySocailApp.Application.Queries.UserAggregate.GetRequesters;
using MySocailApp.Application.Queries.UserAggregate.GetUserById;
using MySocailApp.Application.Queries.UserAggregate.GetUserByUserName;
using MySocailApp.Application.Queries.UserAggregate.GetUserImageById;
using MySocailApp.Application.Queries.UserAggregate.SearchUsers;

namespace MySocailApp.Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize(Roles = "user", AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ServiceFilter(typeof(CheckAccountFilterAttribute))]
    [ServiceFilter(typeof(CheckEmailConfirmationFilterAttribute))]
    public class UsersController(IMediator mediator) : ControllerBase
    {
        private readonly IMediator _mediator = mediator;

        [HttpPut]
        public async Task MakeFollowRequest(MakeFollowRequestDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task CancelFollowRequest(CancelFollowRequestDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task RemoveFollower(RemoveFollowerDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task AcceptFollowRequest(AcceptFollowRequestDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task RejectFollowRequest(RejectFollowRequestDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPost]
        public async Task UpdateImage([FromForm] IFormFile file, CancellationToken cancellationToken)
             => await _mediator.Send(new UpdateUserImageDto(file),cancellationToken);

        [HttpGet]
        public async Task<FileContentResult> RemoveImage(CancellationToken cancellationToken)
             => File(await _mediator.Send(new RemoveUserImageDto(), cancellationToken), "application/octet-stream");

        [HttpPut]
        public async Task MakeProfilePrivate(CancellationToken cancellationToken)
            => await _mediator.Send(new MakeProfilePrivateDto(), cancellationToken);

        [HttpPut]
        public async Task MakeProfilePublic(CancellationToken cancellationToken)
            => await _mediator.Send(new MakeProfilePublicDto(), cancellationToken);

        [HttpPut]
        public async Task UpdateName(UpdateNameDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task UpdateGender(UpdateGenderDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task UpdateBirthDate(UpdateBirthDateDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task Block(BlockDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task Unblock(UnblockDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        //Queries

        [HttpGet("{id}")]
        public async Task<AppUserResponseDto> GetById(int id,CancellationToken cancellationToken)
            => await _mediator.Send(new GetUserByIdDto(id),cancellationToken);

        [HttpGet("{userName}")]
        public async Task<AppUserResponseDto> GetByUserName(string userName,CancellationToken cancellationToken)
            => await _mediator.Send(new GetUserByUserNameDto(userName),cancellationToken);

        [HttpGet("{userId}")]
        public async Task<FileContentResult> GetImageById(int userId, CancellationToken cancellationToken)
            => File(await _mediator.Send(new GetUserImageById(userId), cancellationToken), "application/octet-stream");

        [HttpGet("{id}")]
        public async Task<List<AppUserResponseDto>> GetFollowersById(int id,[FromQuery] int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
            => await _mediator.Send(new GetFollowersByIdDto(id, lastValue, take), cancellationToken);

        [HttpGet("{id}")]
        public async Task<List<AppUserResponseDto>> GetFollowedsById(int id,[FromQuery] int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
            => await _mediator.Send(new GetFollowedsByIdDto(id, lastValue, take), cancellationToken);

        [HttpGet("{id}")]
        public async Task<List<AppUserResponseDto>> GetNotFolloweds(int id,[FromQuery] int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
            => await _mediator.Send(new GetNotFollowedsDto(id, lastValue, take), cancellationToken);

        [HttpGet]
        public async Task<List<AppUserResponseDto>> GetRequesters([FromQuery] int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
            => await _mediator.Send(new GetRequesterDto(lastValue, take), cancellationToken);

        [HttpGet]
        public async Task<List<AppUserResponseDto>> GetRequesteds([FromQuery]int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
            => await _mediator.Send(new GetRequestedsDto(lastValue, take), cancellationToken);
        
        [HttpPost]
        public async Task<List<AppUserResponseDto>> Search(SearchUserDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);
    }
}
