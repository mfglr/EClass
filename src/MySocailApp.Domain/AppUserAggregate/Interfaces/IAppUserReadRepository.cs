﻿using MySocailApp.Domain.AppUserAggregate.Entities;

namespace MySocailApp.Domain.AppUserAggregate.Interfaces
{
    public interface IAppUserReadRepository
    {
        Task<AppUser?> GetAsync(int id, CancellationToken cancellationToken);
        Task<List<int>> GetIdsByUserNames(IEnumerable<string> userNames, CancellationToken cancellationToken);
    }
}
