﻿using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.ConversationContext.MessageAggregate.Interfaces;

namespace MySocailApp.Application.Commands.ConversationContext.MarkMessagesAsViewed
{
    public class MarkMessagesAsViewedHandler(IMessageWriteRepository repository, IAccessTokenReader accessTokenReader, IUnitOfWork unitOfWork) : IRequestHandler<MarkMessagesAsViewedDto>
    {
        private readonly IMessageWriteRepository _repository = repository;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(MarkMessagesAsViewedDto request, CancellationToken cancellationToken)
        {
            var viewerId = _accessTokenReader.GetRequiredAccountId();
            var messages = await _repository.GetByIds(request.Ids, cancellationToken);
            foreach(var message in messages)
                message.MarkAsViewed(viewerId);
            
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
