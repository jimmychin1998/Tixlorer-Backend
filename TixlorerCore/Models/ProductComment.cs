using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class ProductComment
{
    public int CmtId { get; set; }

    public string? PId { get; set; }

    public string? MId { get; set; }

    public string Content { get; set; } = null!;

    public int Rating { get; set; }

    public DateTime CommentTime { get; set; }

    public virtual Member? MIdNavigation { get; set; }

    public virtual Product? PIdNavigation { get; set; }
}
