﻿using MediatR;
using MySocailApp.Application.ApplicationServices.BlobService;
using MySocailApp.Application.Extentions;
using MySocailApp.Domain.AppUserAggregate.Exceptions;
using MySocailApp.Domain.AppUserAggregate.Interfaces;

namespace MySocailApp.Application.Queries.UserAggregate.GetUserImageById
{
    public class GetUserImageByIdHandler(IAppUserReadRepository repository, IBlobService blobService) : IRequestHandler<GetUserImageById, byte[]>
    {
        private readonly IAppUserReadRepository _repository = repository;
        private readonly IBlobService _blobService = blobService;

        public async Task<byte[]> Handle(GetUserImageById request, CancellationToken cancellationToken)
        {
            var user =
                await _repository.GetAsync(request.UserId, cancellationToken) ??
                throw new UserIsNotFoundException();

            if(user.Image != null)
                return await _blobService.Read(ContainerName.UserImages, user.Image.BlobName).ToByteArrayAsync();
            return await _blobService.Read(ContainerName.UserImages, DefaultBlobNames.NoProfileImage).ToByteArrayAsync();
        }
    }
}
