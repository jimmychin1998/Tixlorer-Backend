namespace TixlorerCore.Models
{
    public class MemberWrapper
    {
        internal Member _member;

        public MemberWrapper()
        {
            if (_member == null)
                _member = new Member();
        }
        public Member member { get { return _member; } set { _member = value; } }
        public string MId { get { return _member.MId; } set { _member.MId = value; } }

        public string Email { get { return _member.Email; } set { _member.Email = value; } }

        public string Phone { get { return _member.Phone; } set { _member.Phone = value; } }

        public string Password { get { return _member.Password; } set { _member.Password = value; } }

        public string Name { get { return _member.Name; } set { _member.Name = value; } }

        public int Sex { get { return _member.Sex; } set { _member.Sex = value; } }

        public DateTime Birthday { get { return _member.Birthday; } set { _member.Birthday = value; } }

        public string Address { get { return _member.Address; } set { _member.Address = value; } }

        public string? Credit { get { return _member.Credit; } set { _member.Credit = value; } }

        public string? Favorite { get { return _member.Favorite; } set { _member.Favorite = value; } }

        public int BonusPoint { get { return BonusPoint; } set { _member.BonusPoint = value; } }

        public DateTime RegisterDate { get { return _member.RegisterDate; } set { _member.RegisterDate = value; } }

        public DateTime? LastLoginDate { get { return _member.LastLoginDate; } set { _member.LastLoginDate = value; } }

        public virtual ICollection<BonusPointRecord> BonusPointRecords { get { return _member.BonusPointRecords; } set { _member.BonusPointRecords = value; } }
        public virtual ICollection<Cart> Carts { get { return _member.Carts; } set { _member.Carts = value; } }

        public virtual ICollection<CouponList> CouponLists { get { return _member.CouponLists; } set { _member.CouponLists = value; } }

        public virtual ICollection<CouponUseRecord> CouponUseRecords { get { return _member.CouponUseRecords; } set { _member.CouponUseRecords = value; } }

        public virtual ICollection<DestComment> DestComments
        {
            get { return _member.DestComments; }
            set { _member.DestComments = value; }
        }

        public virtual ICollection<Order> Orders
        {
            get { return _member.Orders; }
            set { _member.Orders = value; }
        }

        public virtual ICollection<ProductComment> ProductComments
        {
            get { return _member.ProductComments; }
            set { _member.ProductComments = value; }
        }
    }
}
