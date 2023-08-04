using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class ComboGroup
{
    public int GroupId { get; set; }

    public string? Name { get; set; }

    public DateTime BuildDate { get; set; }

    public virtual ICollection<CartDetail> CartDetails { get; set; } = new List<CartDetail>();

    public virtual ICollection<ComboGroupDetail> ComboGroupDetails { get; set; } = new List<ComboGroupDetail>();

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
