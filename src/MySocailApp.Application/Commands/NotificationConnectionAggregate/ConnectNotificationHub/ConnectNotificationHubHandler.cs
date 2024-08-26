﻿using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.NotificationConnectionAggregate.Entities;
using MySocailApp.Domain.NotificationConnectionAggregate.Interfaces;

namespace MySocailApp.Application.Commands.NotificationConnectionAggregate.ConnectNotificationHub
{
    public class ConnectNotificationHubHandler(INotificationConnectionWriteRepository writeRepository, IUnitOfWork unitOfWork, IAccessTokenReader accessTokenReader) : IRequestHandler<ConnectNotificationHubDto>
    {
        private readonly INotificationConnectionWriteRepository _writeRepository = writeRepository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;

        public async Task Handle(ConnectNotificationHubDto request, CancellationToken cancellationToken)
        {
            var userId = _accessTokenReader.GetRequiredAccountId();
            var connection = await _writeRepository.GetByIdAsync(userId, cancellationToken);
            if(connection == null)
            {
                connection = new NotificationConnection(userId);
                await _writeRepository.CreateAsync(connection,cancellationToken);
            }
            connection.Connect(request.ConnectionId);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}