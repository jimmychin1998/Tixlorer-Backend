using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class CartDetail
{
    public string CdId { get; set; } = null!;

    public string? CId { get; set; }

    public string? TicketId { get; set; }

    public int? GroupId { get; set; }

    public int Count { get; set; }

    public decimal Totalprice { get; set; }

    public virtual Cart? CIdNavigation { get; set; }

    public virtual ComboGroup? Group { get; set; }

    public virtual Ticket? Ticket { get; set; }
}
