using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class OrderDetail
{
    public int OdId { get; set; }

    public string? OrderId { get; set; }

    public int Type { get; set; }

    public int? GroupId { get; set; }

    public string? PId { get; set; }

    public virtual ComboGroup? Group { get; set; }

    public virtual Order? Order { get; set; }

    public virtual Product? PIdNavigation { get; set; }
}
