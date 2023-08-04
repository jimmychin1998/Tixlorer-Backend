using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class DestComment
{
    public int CmtId { get; set; }

    public string? DestId { get; set; }

    public string? MId { get; set; }

    public string Content { get; set; } = null!;

    public DateTime CommentTime { get; set; }

    public virtual Destination? Dest { get; set; }

    public virtual Member? MIdNavigation { get; set; }
}
