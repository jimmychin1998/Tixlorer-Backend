using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Ticket
{
    public string TicketId { get; set; } = null!;

    public string? DestId { get; set; }

    public string Name { get; set; } = null!;

    public int Type { get; set; }

    public int Capacity { get; set; }

    public decimal Price { get; set; }

    public decimal? DiscountPrice { get; set; }

    public DateTime? Deadline { get; set; }

    public string? Desc { get; set; }

    public int StockNumber { get; set; }

    public DateTime? OnShelf { get; set; }

    public DateTime? OffShelf { get; set; }

    public string? SupplierId { get; set; }

    public int? State { get; set; }

    public virtual ICollection<CartDetail> CartDetails { get; set; } = new List<CartDetail>();

    public virtual ICollection<Coupon> Coupons { get; set; } = new List<Coupon>();

    public virtual Destination? Dest { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();

    public virtual Supplier? Supplier { get; set; }
}
