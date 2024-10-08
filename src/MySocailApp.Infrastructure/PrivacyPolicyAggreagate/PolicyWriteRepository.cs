﻿using MySocailApp.Domain.PrivacyPolicyAggregate;
using MySocailApp.Domain.PrivacyPolicyAggregate.Interfaces;
using MySocailApp.Infrastructure.DbContexts;

namespace MySocailApp.Infrastructure.PrivacyPolicyAggreagate
{
    public class PolicyWriteRepository(AppDbContext context) : IPrivacyPolicyWriteRepository
    {
        private readonly AppDbContext _context = context;

        public async Task CreateAsync(PrivacyPolicy policy, CancellationToken cancellationToken)
            => await _context.PrivacyPolicies.AddAsync(policy, cancellationToken);
    }
}
