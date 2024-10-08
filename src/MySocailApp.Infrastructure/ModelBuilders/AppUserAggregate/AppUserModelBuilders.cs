﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using MySocailApp.Domain.AppUserAggregate.Entities;
using MySocailApp.Domain.NotificationConnectionAggregate.Entities;
using MySocailApp.Domain.UserConnectionAggregate.Entities;

namespace MySocailApp.Infrastructure.ModelBuilders.AppUserAggregate
{
    public class UserModelBuilder : IEntityTypeConfiguration<AppUser>
    {
        public void Configure(EntityTypeBuilder<AppUser> builder)
        {

            builder.Property(e => e.Id).ValueGeneratedNever();
            builder.OwnsOne(x => x.Image);
            builder.OwnsOne(x => x.Biography);

            builder
                .HasOne(x => x.UserConnection)
                .WithOne(x => x.AppUser)
                .HasForeignKey<UserConnection>(x => x.Id)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasOne(x => x.NotificationConnection)
                .WithOne(x => x.AppUser)
                .HasForeignKey<NotificationConnection>(x => x.Id)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(x => x.Questions)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.NoAction);
            builder
                .HasMany(x => x.QuestionsLiked)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasMany(x => x.QuestionsSaved)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(x => x.Solutions)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.NoAction);
            builder
                .HasMany(x => x.SolutionsSaved)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(x => x.Comments)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.NoAction);
            builder
                .HasMany(x => x.CommentsLiked)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasMany(x => x.CommentsTagged)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(x => x.Votes)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(x => x.Messages)
                .WithOne(x => x.Sender)
                .HasForeignKey(x => x.SenderId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasMany(x => x.MessagesReceived)
                .WithOne(x => x.Receiver)
                .HasForeignKey(x => x.ReceiverId)
                .OnDelete(DeleteBehavior.NoAction);
             
            builder
                .HasMany(x => x.Searcheds)
                .WithOne(x => x.Searcher)
                .HasForeignKey(x => x.SearcherId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasMany(x => x.Searchers)
                .WithOne(x => x.Searched)
                .HasForeignKey(x => x.SearchedId)
                .OnDelete(DeleteBehavior.NoAction);

            builder
                .HasMany(x => x.Followers)
                .WithOne(x => x.Followed)
                .HasForeignKey(x => x.FollowedId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasMany(x => x.Followeds)
                .WithOne(x => x.Follower)
                .HasForeignKey(x => x.FollowerId)
                .OnDelete(DeleteBehavior.NoAction);

            builder
                .HasMany(x => x.NotificationsIncoming)
                .WithOne(x => x.Owner)
                .HasForeignKey(x => x.OwnerId)
                .OnDelete(DeleteBehavior.NoAction);
            builder
                .HasMany(x => x.NotificationsOutgoing)
                .WithOne(x => x.AppUser)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.NoAction);
        }
    }
}
