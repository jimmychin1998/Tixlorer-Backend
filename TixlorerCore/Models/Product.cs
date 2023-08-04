using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Product
{
    public string PId { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string? TicketId { get; set; }

    public int? GroupId { get; set; }

    public decimal Price { get; set; }

    public decimal? DiscountPrice { get; set; }

    public string? Desc { get; set; }

    public string? Image { get; set; }

    public int StockNumber { get; set; }

    public DateTime? OnShelf { get; set; }

    public DateTime? OffShelf { get; set; }

    public int State { get; set; }

    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();

    public virtual ICollection<ComboGroupDetail> ComboGroupDetails { get; set; } = new List<ComboGroupDetail>();

    public virtual ComboGroup? Group { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<ProductComment> ProductComments { get; set; } = new List<ProductComment>();

    public virtual Ticket? Ticket { get; set; }
}
