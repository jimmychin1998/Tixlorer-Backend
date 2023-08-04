using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Order
{
    public string OrderId { get; set; } = null!;

    public string? MId { get; set; }

    public string? PId { get; set; }

    public DateTime Orderdate { get; set; }

    public DateTime? OrderdateEnd { get; set; }

    public int State { get; set; }

    public int Count { get; set; }

    public decimal Totalprice { get; set; }

    public virtual ICollection<BonusPointRecord> BonusPointRecords { get; set; } = new List<BonusPointRecord>();

    public virtual ICollection<CouponUseRecord> CouponUseRecords { get; set; } = new List<CouponUseRecord>();

    public virtual Member? MIdNavigation { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual Product? PIdNavigation { get; set; }
}
