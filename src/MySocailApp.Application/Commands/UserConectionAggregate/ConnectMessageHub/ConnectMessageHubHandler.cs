﻿using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.UserConnectionAggregate.Entities;
using MySocailApp.Domain.UserConnectionAggregate.Interfaces;

namespace MySocailApp.Application.Commands.UserConectionAggregate.ConnectMessageHub
{
    public class ConnectMessageHubHandler(IAccessTokenReader tokenReader, IUserConnectionWriteRepository repository, IUnitOfWork unitOfWork) : IRequestHandler<ConnectMessageHubDto>
    {
        private readonly IAccessTokenReader _tokenReader = tokenReader;
        private readonly IUserConnectionWriteRepository _repository = repository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(ConnectMessageHubDto request, CancellationToken cancellationToken)
        {
            var userId = _tokenReader.GetRequiredAccountId();
            var connection = await _repository.GetByIdAsync(userId, cancellationToken);
            if (connection == null)
            {
                connection = new UserConnection(userId);
                await _repository.CreateAsync(connection, cancellationToken);
            }
            connection.Connect(request.ConnectionId);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
