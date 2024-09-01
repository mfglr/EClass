﻿using AutoMapper;
using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.SolutionAggregate.Exceptions;
using MySocailApp.Domain.SolutionAggregate.Interfaces;

namespace MySocailApp.Application.Commands.SolutionAggregate.MakeDownvote
{
    public class MakeDownVoteHandler(ISolutionWriteRepository writeRepository, IAccessTokenReader tokenReader, IUnitOfWork unitOfWork, IMapper mapper) : IRequestHandler<MakeDownvoteDto, MakeDownvoteCommandResponseDto>
    {
        private readonly ISolutionWriteRepository _writeRepository = writeRepository;
        private readonly IAccessTokenReader _tokenReader = tokenReader;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;
        private readonly IMapper _mapper = mapper;

        public async Task<MakeDownvoteCommandResponseDto> Handle(MakeDownvoteDto request, CancellationToken cancellationToken)
        {
            var voterId = _tokenReader.GetRequiredAccountId();
            var solution =
                await _writeRepository.GetWithVotesByIdAsync(request.SolutionId, cancellationToken) ??
                throw new SolutionNotFoundException();
            var vote = solution.MakeDownvote(voterId);
            await _unitOfWork.CommitAsync(cancellationToken);

            return _mapper.Map<MakeDownvoteCommandResponseDto>(vote);
        }
    }
}
