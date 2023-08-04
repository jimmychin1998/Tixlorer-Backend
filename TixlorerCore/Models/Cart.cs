using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Cart
{
    public string CId { get; set; } = null!;

    public string? MId { get; set; }

    public int Type { get; set; }

    public string? PId { get; set; }

    public int Count { get; set; }

    public decimal Totalprice { get; set; }

    public virtual ICollection<CartDetail> CartDetails { get; set; } = new List<CartDetail>();

    public virtual Member? MIdNavigation { get; set; }

    public virtual Product? PIdNavigation { get; set; }
}
