﻿namespace MySocailApp.Domain.SolutionAggregate.Entities
{
    public class SolutionVoteNotification(int appUserId)
    {
        public int SolutionId { get; private set; }
        public int AppUserId { get; private set; } = appUserId;

        public Solution Solution { get; } = null!;
        public Solution AppUser { get; } = null!;
    }
}
