﻿namespace MySocailApp.Application.Queries.QuestionAggregate
{
    public record QuestionUserSaveResponseDto(int Id, DateTime CreatedAt, int QuestionId, int AppUserId, QuestionResponseDto Question);
}
