﻿using MySocailApp.Domain.ConversationContext.UserConnectionAggregate.Entities;
using MySocailApp.Domain.ConversationContext.UserConnectionAggregate.Interfaces;
using MySocailApp.Infrastructure.DbContexts;

namespace MySocailApp.Infrastructure.ConversationContext.UserConnectionAggregate
{
    public class UserConnectionWriteRepository(AppDbContext context) : IUserConnectionWriteRepository
    {
        private readonly AppDbContext _context = context;

        public async Task CreateAsync(UserConnection userConnection, CancellationToken cancellationToken)
            => await _context.UserConnections.AddAsync(userConnection, cancellationToken);

        public async Task<UserConnection?> GetByIdAsync(int id, CancellationToken cancellationToken)
            => await _context.UserConnections.FindAsync(id, cancellationToken);
    }
}
