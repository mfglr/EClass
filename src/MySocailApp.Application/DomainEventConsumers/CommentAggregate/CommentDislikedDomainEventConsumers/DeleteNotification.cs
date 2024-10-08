﻿using MySocailApp.Application.ApplicationServices;
using MySocailApp.Core;
using MySocailApp.Domain.CommentAggregate.DomainEvents;
using MySocailApp.Domain.NotificationAggregate.Interfaces;

namespace MySocailApp.Application.DomainEventConsumers.CommentAggregate.CommentDislikedDomainEventConsumers
{
    public class DeleteNotification(INotificationWriteRepository notificationWriteRepository, IUnitOfWork unitOfWork) : IDomainEventConsumer<CommentDislikedDomainEvent>
    {
        private readonly INotificationWriteRepository _notificationWriteRepository = notificationWriteRepository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(CommentDislikedDomainEvent notification, CancellationToken cancellationToken)
        {
            var n = await _notificationWriteRepository.GetCommentLikedNotificationAsync(notification.Comment.Id, notification.Comment.AppUserId, cancellationToken);
            if (n == null) return;

            _notificationWriteRepository.Delete(n);
            await _unitOfWork.CommitAsync(cancellationToken);

        }
    }
}
