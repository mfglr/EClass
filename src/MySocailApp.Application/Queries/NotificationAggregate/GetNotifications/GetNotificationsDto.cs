﻿using MediatR;
using MySocailApp.Core;

namespace MySocailApp.Application.Queries.NotificationAggregate.GetNotifications
{
    public class GetNotificationsDto(int? offset, int take,bool isDescending) : Page(offset,take,isDescending), IRequest<List<NotificationResponseDto>>;
}
