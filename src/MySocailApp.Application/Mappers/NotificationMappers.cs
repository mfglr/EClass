﻿using AutoMapper;
using MySocailApp.Application.Queries.NotificationAggregate;
using MySocailApp.Domain.NotificationAggregate.Entities;
using MySocailApp.Domain.NotificationAggregate.ValueObjects;

namespace MySocailApp.Application.Mappers
{
    public class NotificationMappers : Profile
    {
        public NotificationMappers()
        {
            CreateMap<Notification, NotificationResponseDto>()
                .ForMember(dest => dest.UserName,x => x.MapFrom(src => src.User.Account.UserName))
                .ForMember(dest => dest.Content,x => x.MapFrom(src => src.Comment != null ? src.Comment.Content.Value : null));
        }

    }
}
