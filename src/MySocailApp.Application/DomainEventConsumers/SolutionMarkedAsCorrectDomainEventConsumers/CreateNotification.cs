﻿using MySocailApp.Application.ApplicationServices;
using MySocailApp.Core;
using MySocailApp.Domain.NotificationAggregate.Entities;
using MySocailApp.Domain.NotificationAggregate.Interfaces;
using MySocailApp.Domain.QuestionAggregate.Interfaces;
using MySocailApp.Domain.SolutionAggregate.DomainEvents;

namespace MySocailApp.Application.DomainEventConsumers.SolutionMarkedAsCorrectDomainEventConsumers
{
    public class CreateNotification(IQuestionReadRepository questionReadRepository, INotificationWriteRepository notificationWriteRepository, IUnitOfWork unitOfWork) : IDomainEventConsumer<SolutionMarkedAsCorrectDomainEvent>
    {
        private readonly IQuestionReadRepository _questionReadRepository = questionReadRepository;
        private readonly INotificationWriteRepository _notificationWriteRepository = notificationWriteRepository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(SolutionMarkedAsCorrectDomainEvent notification, CancellationToken cancellationToken)
        {
            var solution = notification.Solution;
            var question = await _questionReadRepository.GetAsync(solution.QuestionId, cancellationToken);
            if (question == null) return;

            var n = Notification.SolutionMarkedAsCorrectNotification(solution.AppUserId, question.AppUserId, solution.Id);
            await _notificationWriteRepository.CreateAsync(n, cancellationToken);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
