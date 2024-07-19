﻿using MediatR;
using MySocailApp.Application.Services;
using MySocailApp.Domain.QuestionAggregate.Excpetions;
using MySocailApp.Domain.QuestionAggregate.Repositories;

namespace MySocailApp.Application.Commands.QuestionAggregate.LikeQuestion
{
    public class LikeQuestionHandler(IAccessTokenReader tokenReader, IQuestionWriteRepository repository, IUnitOfWork unitOfWork) : IRequestHandler<LikeQuestionDto>
    {
        private readonly IAccessTokenReader _tokenReader = tokenReader;
        private readonly IQuestionWriteRepository _repository = repository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(LikeQuestionDto request, CancellationToken cancellationToken)
        {
            var userId = _tokenReader.GetRequiredAccountId();
            var question = 
                await _repository.GetWithLikeByIdAsync(request.QuestionId, userId, cancellationToken) ??
                throw new QuestionIsNotFoundException();
            question.Like(userId);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
