﻿using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.AccountAggregate.DomainServices;
using MySocailApp.Domain.AccountAggregate.Entities;

namespace MySocailApp.Application.Commands.AccountAggregate.UpdateEmailConfirmationToken
{
    public class UpdateEmailConfirmationTokenHandler(IAccessTokenReader tokenReader, UserManager<Account> userManager) : IRequestHandler<UpdateEmailConfirmationTokenDto>
    {
        private readonly IAccessTokenReader _tokenReader = tokenReader;
        private readonly UserManager<Account> _userManager = userManager;

        public async Task Handle(UpdateEmailConfirmationTokenDto request, CancellationToken cancellationToken)
        {
            var accountId = _tokenReader.GetRequiredAccountId();
            var account = (await _userManager.FindByIdAsync(accountId.ToString()))!;
            account.UpdateEmailConfirmationToken();
            await _userManager.UpdateAsync(account);
        }
    }
}
