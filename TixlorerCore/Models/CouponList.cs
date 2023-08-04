using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class CouponList
{
    public int CouponlistId { get; set; }

    public string CouponId { get; set; } = null!;

    public string MId { get; set; } = null!;

    public DateTime GetDate { get; set; }

    public virtual Coupon Coupon { get; set; } = null!;

    public virtual Member MIdNavigation { get; set; } = null!;
}
