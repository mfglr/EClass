﻿using MySocailApp.Core;
using MySocailApp.Domain.CommentAggregate.Entities;

namespace MySocailApp.Domain.CommentAggregate.DomainEvents
{
    public record CommentDeletedDomainEvent(Comment Comment) : IDomainEvent;
}
