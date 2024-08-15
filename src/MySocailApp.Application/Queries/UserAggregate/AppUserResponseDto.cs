﻿using MySocailApp.Domain.AppUserAggregate.ValueObjects;

namespace MySocailApp.Application.Queries.UserAggregate
{
    public class AppUserResponseDto
    {
        public int Id { get; private set; }
        public DateTime CreatedAt { get; private set; }
        public DateTime? UpdatedAt { get; private set; }
        public string UserName { get; private set; } = null!;
        public string? Name { get; private set; }
        public DateTime? BirthDate { get; private set; }
        public Gender Gender { get; private set; }
        public bool HasImage { get; private set; }
        public int NumberOfQuestions { get; private set; }
        public int NumberOfFollowers { get; private set; }
        public int NumberOfFolloweds { get; private set; }
        public bool IsFollower { get; private set; }
        public bool IsFollowed { get; private set; }

        private AppUserResponseDto() { }
    }
}
