﻿using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.QuestionAggregate.Excpetions;
using MySocailApp.Domain.QuestionAggregate.Interfaces;

namespace MySocailApp.Application.Commands.QuestionAggregate.UnsaveQuestion
{
    public class UnsaveQuestionHandler(IQuestionWriteRepository questionWriteRepository, IAccessTokenReader accessTokenReader, IUnitOfWork unitOfWork) : IRequestHandler<UnsaveQuestionDto>
    {
        private readonly IQuestionWriteRepository _questionWriteRepository = questionWriteRepository;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(UnsaveQuestionDto request, CancellationToken cancellationToken)
        {
            var saverId = _accessTokenReader.GetRequiredAccountId();
            var question =
                await _questionWriteRepository.GetQuestionWithSaveAsync(request.QuestionId, saverId, cancellationToken) ??
                throw new QuestionNotFoundException();
            question.Unsave(saverId);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
