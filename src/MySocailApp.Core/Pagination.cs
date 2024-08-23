﻿namespace MySocailApp.Core
{
    public class Pagination(int? offset, int take, bool isDescending) : IPagination
    {
        public int? Offset { get; private set; } = offset;
        public int Take { get; private set; } = take;
        public bool IsDescending { get; private set; } = isDescending;
    }
}
