using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Member
{
    public string MId { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Name { get; set; } = null!;

    public int Sex { get; set; }

    public DateTime Birthday { get; set; }

    public string Address { get; set; } = null!;

    public string? Credit { get; set; }

    public string? Favorite { get; set; }

    public int BonusPoint { get; set; }

    public DateTime RegisterDate { get; set; }

    public DateTime? LastLoginDate { get; set; }

    public virtual ICollection<BonusPointRecord> BonusPointRecords { get; set; } = new List<BonusPointRecord>();

    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();

    public virtual ICollection<CouponList> CouponLists { get; set; } = new List<CouponList>();

    public virtual ICollection<CouponUseRecord> CouponUseRecords { get; set; } = new List<CouponUseRecord>();

    public virtual ICollection<DestComment> DestComments { get; set; } = new List<DestComment>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<ProductComment> ProductComments { get; set; } = new List<ProductComment>();
}
