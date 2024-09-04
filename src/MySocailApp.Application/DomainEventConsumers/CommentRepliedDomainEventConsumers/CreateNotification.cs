﻿using AutoMapper;
using Microsoft.AspNetCore.SignalR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Application.Hubs;
using MySocailApp.Application.Queries.NotificationAggregate;
using MySocailApp.Core;
using MySocailApp.Domain.CommentAggregate.DomainEvents;
using MySocailApp.Domain.NotificationAggregate.Entities;
using MySocailApp.Domain.NotificationAggregate.Interfaces;
using MySocailApp.Domain.NotificationConnectionAggregate.Interfaces;

namespace MySocailApp.Application.DomainEventConsumers.CommentRepliedDomainEventConsumers
{
    public class CreateNotification(INotificationWriteRepository notficationWriteRepository, IUnitOfWork unitOfWork, IHubContext<NotificationHub> notificationHub, INotificationConnectionReadRepository notificationConnectionReadRepository, IMapper mapper) : IDomainEventConsumer<CommentRepliedDomainEvent>
    {
        private readonly IHubContext<NotificationHub> _notificationHub = notificationHub;
        private readonly INotificationConnectionReadRepository _notificationConnectionReadRepository = notificationConnectionReadRepository;
        private readonly IMapper _mapper = mapper;

        private readonly INotificationWriteRepository _notficationWriteRepository = notficationWriteRepository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(CommentRepliedDomainEvent notification, CancellationToken cancellationToken)
        {
            var comment = notification.Comment;
            var repliedComment = notification.RepliedComment;
            var parentComment = notification.ParentComment;

            var n = Notification.CommentRepliedNotification(repliedComment.AppUserId, comment.AppUserId, comment.Id, parentComment.QuestionId, parentComment.SolutionId, parentComment.Id, repliedComment.Id);
            await _notficationWriteRepository.CreateAsync(n, cancellationToken);
            await _unitOfWork.CommitAsync(cancellationToken);

            var connection = await _notificationConnectionReadRepository.GetByIdAsync(repliedComment.AppUserId, cancellationToken);
            if (connection == null || !connection.IsConnected) return;

            await _notificationHub.Clients
                .Client(connection.ConnectionId!)
                .SendAsync(
                    "getNotification",
                    _mapper.Map<NotificationResponseDto>(n),
                    cancellationToken
                );
        }
    }
}
