﻿using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySocailApp.Api.Filters;
using MySocailApp.Application.Commands.SolutionAggregate.CreateSolution;
using MySocailApp.Application.Commands.SolutionAggregate.DeleteSolution;
using MySocailApp.Application.Commands.SolutionAggregate.MakeDownvote;
using MySocailApp.Application.Commands.SolutionAggregate.MakeUpvote;
using MySocailApp.Application.Commands.SolutionAggregate.MarkSolutionAsCorrect;
using MySocailApp.Application.Commands.SolutionAggregate.MarkSolutionAsIncorrect;
using MySocailApp.Application.Commands.SolutionAggregate.RemoveDownvote;
using MySocailApp.Application.Commands.SolutionAggregate.RemoveUpvote;
using MySocailApp.Application.Queries.SolutionAggregate;
using MySocailApp.Application.Queries.SolutionAggregate.GetCorrectSolutionsByQuestionId;
using MySocailApp.Application.Queries.SolutionAggregate.GetIncorrectsSolutionsByQuestionId;
using MySocailApp.Application.Queries.SolutionAggregate.GetPendingSolutionsByQuestionId;
using MySocailApp.Application.Queries.SolutionAggregate.GetSolutionById;
using MySocailApp.Application.Queries.SolutionAggregate.GetSolutionDownvotes;
using MySocailApp.Application.Queries.SolutionAggregate.GetSolutionImage;
using MySocailApp.Application.Queries.SolutionAggregate.GetSolutionsByQuestionId;
using MySocailApp.Application.Queries.SolutionAggregate.GetSolutionUpvotes;

namespace MySocailApp.Api.Controllers.Api
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize(Roles = "user", AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ServiceFilter(typeof(CheckAccountFilterAttribute))]
    [ServiceFilter(typeof(CheckEmailConfirmationFilterAttribute))]
    public class SolutionsController(IMediator mediator) : ControllerBase
    {
        private readonly IMediator _mediator = mediator;

        [HttpPost]
        public async Task<SolutionResponseDto> Create([FromForm] string? content, [FromForm] int questionId, [FromForm] IFormFileCollection images, CancellationToken cancellationToken)
            => await _mediator.Send(new CreateSolutionDto(content, questionId, images), cancellationToken);

        [HttpDelete("{solutionId}")]
        public async Task Delete(int solutionId, CancellationToken cancellationToken)
            => await _mediator.Send(new DeleteSolutionDto(solutionId), cancellationToken);

        [HttpPost]
        public async Task<MakeUpvoteCommandResponseDto> MakeUpvote(MakeUpvoteDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);
        [HttpDelete("{solutionId}")]
        public async Task RemoveUpvote(int solutionId, CancellationToken cancellationToken)
            => await _mediator.Send(new RemoveUpvoteDto(solutionId), cancellationToken);

        [HttpPost]
        public async Task<MakeDownvoteCommandResponseDto> MakeDownvote(MakeDownvoteDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);
        [HttpDelete("{solutionId}")]
        public async Task RemoveDownvote(int solutionId, CancellationToken cancellationToken)
            => await _mediator.Send(new RemoveDownvoteDto(solutionId), cancellationToken);

        [HttpPut]
        public async Task MarkAsCorrect(MarkSolutionAsCorrectDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);
        [HttpPut]
        public async Task MarkAsIncorrect(MarkSolutionAsIncorrectDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);


        [HttpGet("{solutionId}/{solutionImageId}")]
        public async Task<FileResult> GetSolutionImage(int solutionId, int solutionImageId, CancellationToken cancellationToken)
             => File(
               await _mediator.Send(new GetSolutionImageDto(solutionId, solutionImageId), cancellationToken),
               "application/octet-stream"
            );

        [HttpGet("{id}")]
        public async Task<SolutionResponseDto> GetSolutionById(int id, CancellationToken cancellationToken)
            => await _mediator.Send(new GetSolutionByIdDto(id), cancellationToken);

        [HttpGet("{questionId}")]
        public async Task<List<SolutionResponseDto>> GetSolutionsByQuestionId(int questionId, [FromQuery] int? offset, [FromQuery] int take, [FromQuery] bool isDescending, CancellationToken cancellationToken)
            => await _mediator.Send(new GetSolutionsByQuestionIdDto(questionId, offset, take, isDescending), cancellationToken);

        [HttpGet("{questionId}")]
        public async Task<List<SolutionResponseDto>> GetCorrectSolutionsByQuestionId(int questionId, [FromQuery] int? offset, [FromQuery] int take, [FromQuery] bool isDescending, CancellationToken cancellationToken)
            => await _mediator.Send(new GetCorrectSolutionsByQuestionIdDto(questionId, offset, take, isDescending), cancellationToken);

        [HttpGet("{questionId}")]
        public async Task<List<SolutionResponseDto>> GetPendingSolutionsByQuestionId(int questionId, [FromQuery] int? offset, [FromQuery] int take, [FromQuery] bool isDescending, CancellationToken cancellationToken)
            => await _mediator.Send(new GetPendingSolutionsByQuestionIdDto(questionId, offset, take, isDescending), cancellationToken);

        [HttpGet("{questionId}")]
        public async Task<List<SolutionResponseDto>> GetIncorrectSolutionsByQuestionId(int questionId, [FromQuery] int? offset, [FromQuery] int take, [FromQuery] bool isDescending, CancellationToken cancellationToken)
            => await _mediator.Send(new GetIncorrectSolutionsByQuestionIdDto(questionId, offset, take, isDescending), cancellationToken);

        [HttpGet("{solutionId}")]
        public async Task<List<SolutionUserVoteResponseDto>> GetSolutionUpvotes(int solutionId, [FromQuery] int? offset, [FromQuery] int take, [FromQuery] bool isDescending, CancellationToken cancellationToken)
            => await _mediator.Send(new GetSolutionUpvotesDto(solutionId, offset, take, isDescending), cancellationToken);

        [HttpGet("{solutionId}")]
        public async Task<List<SolutionUserVoteResponseDto>> GetSolutionDownvotes(int solutionId, [FromQuery] int? offset, [FromQuery] int take, [FromQuery] bool isDescending, CancellationToken cancellationToken)
            => await _mediator.Send(new GetSolutionDownvotesDto(solutionId, offset, take, isDescending), cancellationToken);
    }
}