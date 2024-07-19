﻿using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using MySocailApp.Application.Services;
using MySocailApp.Domain.AccountAggregate;

namespace MySocailApp.Application.Commands.AccountAggregate.UpdateEmail
{
    public class UpdateEmailHandler(IMapper mapper, IAccessTokenReader tokenReader, AccountManager accountManager, UserManager<Account> userManager) : IRequestHandler<UpdateEmailDto, AccountDto>
    {
        private readonly AccountManager _accountManager = accountManager;
        private readonly IAccessTokenReader _tokenReader = tokenReader;
        private readonly UserManager<Account> _userManager = userManager;
        private readonly IMapper _mapper = mapper;

        public async Task<AccountDto> Handle(UpdateEmailDto request, CancellationToken cancellationToken)
        {
            var accountId = _tokenReader.GetRequiredAccountId();
            var account = (await _userManager.FindByIdAsync(accountId.ToString()))!;
            await _accountManager.UpdateEmailAsync(account, request.Email);
            return _mapper.Map<AccountDto>(account);
        }
    }
}
