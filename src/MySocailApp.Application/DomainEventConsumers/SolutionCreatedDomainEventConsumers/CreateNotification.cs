﻿using AutoMapper;
using Microsoft.AspNetCore.SignalR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Application.Hubs;
using MySocailApp.Application.Queries.NotificationAggregate;
using MySocailApp.Application.Queries.SolutionAggregate;
using MySocailApp.Core;
using MySocailApp.Domain.NotificationAggregate.Entities;
using MySocailApp.Domain.NotificationAggregate.Interfaces;
using MySocailApp.Domain.NotificationConnectionAggregate.Interfaces;
using MySocailApp.Domain.QuestionAggregate.Interfaces;
using MySocailApp.Domain.SolutionAggregate.DomainEvents;
using MySocailApp.Domain.SolutionAggregate.Interfaces;

namespace MySocailApp.Application.DomainEventConsumers.SolutionCreatedDomainEventConsumers
{
    public class CreateNotification(INotificationWriteRepository notificationRepsitory, IUnitOfWork unitOfWork, IQuestionReadRepository questionRepository, IHubContext<NotificationHub> notificationHub, INotificationConnectionReadRepository notificationConnectionReadRepository, IMapper mapper, ISolutionReadRepository solutionReadRepository) : IDomainEventConsumer<SolutionCreatedDomainEvent>
    {
        private readonly IHubContext<NotificationHub> _notificationHub = notificationHub;
        private readonly INotificationConnectionReadRepository _notificationConnectionReadRepository = notificationConnectionReadRepository;
        private readonly ISolutionReadRepository _solutionReadRepository = solutionReadRepository;
        private readonly IMapper _mapper = mapper;


        private readonly INotificationWriteRepository _notificationRepsitory = notificationRepsitory;
        private readonly IQuestionReadRepository _questionRepository = questionRepository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(SolutionCreatedDomainEvent notification, CancellationToken cancellationToken)
        {
            var solution = notification.Solution;
            var question = await _questionRepository.GetAsync(solution.QuestionId, cancellationToken);
            if (question == null) return;

            var n = Notification.SolutionCreatedNotification(question.AppUserId, question.Id, solution.Id, solution.AppUserId);
            await _notificationRepsitory.CreateAsync(n, cancellationToken);
            await _unitOfWork.CommitAsync(cancellationToken);

            var connection = await _notificationConnectionReadRepository.GetByIdAsync(question.AppUserId, cancellationToken);
            if (connection == null || !connection.IsConnected) return;

            var s = await _solutionReadRepository.GetByIdAsync(solution.Id, cancellationToken);
            if(s == null) return;

            var ms = _mapper.Map<SolutionResponseDto>(s);
            var mn = _mapper.Map<NotificationResponseDto>(n);
            await _notificationHub.Clients.Client(connection.ConnectionId!).SendAsync("getNotification", mn, ms, cancellationToken);
        }
    }
}
