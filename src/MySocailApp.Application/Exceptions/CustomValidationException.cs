﻿using MySocailApp.Core.Exceptions;
using System.Net;

namespace MySocailApp.Application.Exceptions
{
    public class CustomValidationException(IEnumerable<string> message) : AppException(message, (int)HttpStatusCode.BadRequest)
    {
    }
}
