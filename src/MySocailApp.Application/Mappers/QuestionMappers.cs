﻿using AutoMapper;
using MySocailApp.Application.Commands.QuestionAggregate.LikeQuestion;
using MySocailApp.Application.Commands.QuestionAggregate.SaveQuestion;
using MySocailApp.Application.Queries.QuestionAggregate;
using MySocailApp.Domain.QuestionAggregate.Entities;

namespace MySocailApp.Application.Mappers
{
    public class QuestionMappers : Profile
    {
        public QuestionMappers()
        {
            CreateMap<QuestionUserLike, QuestionUserLikeResponseDto>();
            CreateMap<QuestionImage, QuestionImageResponseDto>();
            CreateMap<QuestionUserLike, LikeQuestionCommandResponseDto>();
            CreateMap<QuestionUserSave, SaveQuestionCommandResponseDto>();
        }
    }
}
