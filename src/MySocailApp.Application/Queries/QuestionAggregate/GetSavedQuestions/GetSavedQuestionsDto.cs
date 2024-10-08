﻿using MediatR;
using MySocailApp.Core;

namespace MySocailApp.Application.Queries.QuestionAggregate.GetSavedQuestions
{
    public class GetSavedQuestionsDto(int offset, int take, bool isDescending) : Page(offset,take,isDescending), IRequest<List<QuestionUserSaveResponseDto>>;
}
