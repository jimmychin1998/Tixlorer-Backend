using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Coupon
{
    public string CouponId { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string PId { get; set; } = null!;

    public int DiscountType { get; set; }

    public int Discount { get; set; }

    public int UsableDay { get; set; }

    public DateTime? ExpirationDate { get; set; }

    public virtual ICollection<CouponList> CouponLists { get; set; } = new List<CouponList>();

    public virtual Ticket PIdNavigation { get; set; } = null!;
}
