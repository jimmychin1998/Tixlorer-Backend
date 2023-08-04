using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Supplier
{
    public string SupplierId { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string County { get; set; } = null!;

    public string Address { get; set; } = null!;

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
