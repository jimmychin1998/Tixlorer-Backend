using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class BonusPointRecord
{
    public int SerialId { get; set; }

    public int OperateType { get; set; }

    public int BonusPoint { get; set; }

    public DateTime Date { get; set; }

    public string? MId { get; set; }

    public string? OrderId { get; set; }

    public virtual Member? MIdNavigation { get; set; }

    public virtual Order? Order { get; set; }
}
