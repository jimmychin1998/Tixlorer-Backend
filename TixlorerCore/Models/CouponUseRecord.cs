using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class CouponUseRecord
{
    public int SerialId { get; set; }

    public DateTime UseDate { get; set; }

    public string? MId { get; set; }

    public string? OrderId { get; set; }

    public virtual Member? MIdNavigation { get; set; }

    public virtual Order? Order { get; set; }
}
