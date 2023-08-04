using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class ComboGroupDetail
{
    public int SerialId { get; set; }

    public int? GroupId { get; set; }

    public string? PId { get; set; }

    public virtual ComboGroup? Group { get; set; }

    public virtual Product? PIdNavigation { get; set; }
}
