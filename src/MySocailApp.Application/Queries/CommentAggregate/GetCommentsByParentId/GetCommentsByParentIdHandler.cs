﻿using AutoMapper;
using MediatR;
using MySocailApp.Domain.CommentAggregate.Interfaces;

namespace MySocailApp.Application.Queries.CommentAggregate.GetCommentsByParentId
{
    public class GetCommentsByParentIdHandler(IMapper mapper, ICommentReadRepository repository) : IRequestHandler<GetCommentsByParentIdDto, List<CommentResponseDto>>
    {
        private readonly IMapper _mapper = mapper;
        private readonly ICommentReadRepository _repository = repository;

        public async Task<List<CommentResponseDto>> Handle(GetCommentsByParentIdDto request, CancellationToken cancellationToken)
        {
            var comments = await _repository.GetCommentsByParentIdAsync(request.ParentId, request, cancellationToken);
            return _mapper.Map<List<CommentResponseDto>>(comments);
        }
    }
}
