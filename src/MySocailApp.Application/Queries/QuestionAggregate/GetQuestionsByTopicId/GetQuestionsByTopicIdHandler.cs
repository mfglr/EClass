﻿using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Application.QueryRepositories;

namespace MySocailApp.Application.Queries.QuestionAggregate.GetQuestionsByTopicId
{
    public class GetQuestionsByTopicIdHandler(IQuestionQueryRepository repository, IAccessTokenReader accessTokenReader) : IRequestHandler<GetQuestionsByTopicIdDto, List<QuestionResponseDto>>
    {
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IQuestionQueryRepository _repository = repository;

        public Task<List<QuestionResponseDto>> Handle(GetQuestionsByTopicIdDto request, CancellationToken cancellationToken)
            => _repository
                .GetTopicQuestionsAsync(
                    request.TopicId,
                    _accessTokenReader.GetRequiredAccountId(),
                    request,
                    cancellationToken
                );
    }
}
