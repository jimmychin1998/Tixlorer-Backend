using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Destination
{
    public string DestId { get; set; } = null!;

    public string Name { get; set; } = null!;

    public int Type { get; set; }

    public string County { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Address { get; set; } = null!;

    public decimal Longitude { get; set; }

    public decimal Latitude { get; set; }

    public string? Desc { get; set; }

    public string? Image { get; set; }

    public DateTime? OnShelf { get; set; }

    public DateTime? OffShelf { get; set; }

    public string? Url { get; set; }

    public virtual ICollection<DestComment> DestComments { get; set; } = new List<DestComment>();

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
