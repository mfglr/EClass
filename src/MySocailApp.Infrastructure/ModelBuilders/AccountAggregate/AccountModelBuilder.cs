﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using MySocailApp.Domain.AccountAggregate;
using MySocailApp.Domain.AppUserAggregate;

namespace MySocailApp.Infrastructure.ModelBuilders.AccountAggregate
{
    public class AccountModelBuilder : IEntityTypeConfiguration<Account>
    {
        public void Configure(EntityTypeBuilder<Account> builder)
        {
            builder.OwnsOne(x => x.EmailConfirmationToken);

            builder
                .HasOne(x => x.AppUser)
                .WithOne(x => x.Account)
                .HasForeignKey<AppUser>(x => x.Id);
        }
    }
}
