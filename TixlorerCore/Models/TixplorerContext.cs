using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace TixlorerCore.Models;

public partial class TixplorerContext : DbContext
{
    public TixplorerContext()
    {
    }

    public TixplorerContext(DbContextOptions<TixplorerContext> options)
        : base(options)
    {
    }

    public virtual DbSet<BonusPointRecord> BonusPointRecords { get; set; }

    public virtual DbSet<Cart> Carts { get; set; }

    public virtual DbSet<CartDetail> CartDetails { get; set; }

    public virtual DbSet<ComboGroup> ComboGroups { get; set; }

    public virtual DbSet<ComboGroupDetail> ComboGroupDetails { get; set; }

    public virtual DbSet<Coupon> Coupons { get; set; }

    public virtual DbSet<CouponList> CouponLists { get; set; }

    public virtual DbSet<CouponUseRecord> CouponUseRecords { get; set; }

    public virtual DbSet<DestComment> DestComments { get; set; }

    public virtual DbSet<Destination> Destinations { get; set; }

    public virtual DbSet<Member> Members { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductComment> ProductComments { get; set; }

    public virtual DbSet<Staff> Staff { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    public virtual DbSet<Ticket> Tickets { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=Tixplorer;Integrated Security=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<BonusPointRecord>(entity =>
        {
            entity.HasKey(e => e.SerialId);

            entity.ToTable("Bonus_Point_Record");

            entity.Property(e => e.SerialId).HasColumnName("serial_id");
            entity.Property(e => e.BonusPoint).HasColumnName("bonus_point");
            entity.Property(e => e.Date)
                .HasColumnType("datetime")
                .HasColumnName("date");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");
            entity.Property(e => e.OperateType).HasColumnName("operate_type");
            entity.Property(e => e.OrderId)
                .HasMaxLength(20)
                .HasColumnName("order_id");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.BonusPointRecords)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Bonus_Point_Record_Member");

            entity.HasOne(d => d.Order).WithMany(p => p.BonusPointRecords)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Bonus_Point_Record_Order");
        });

        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => e.CId);

            entity.ToTable("Cart");

            entity.Property(e => e.CId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getCartID]())")
                .HasColumnName("c_id");
            entity.Property(e => e.Count).HasColumnName("count");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");
            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasColumnName("p_id");
            entity.Property(e => e.Totalprice)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("totalprice");
            entity.Property(e => e.Type).HasColumnName("type");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.Carts)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Cart_Member");

            entity.HasOne(d => d.PIdNavigation).WithMany(p => p.Carts)
                .HasForeignKey(d => d.PId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Cart_Product");
        });

        modelBuilder.Entity<CartDetail>(entity =>
        {
            entity.HasKey(e => e.CdId);

            entity.ToTable("Cart_Detail");

            entity.Property(e => e.CdId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getCartDetailID]())")
                .HasColumnName("cd_id");
            entity.Property(e => e.CId)
                .HasMaxLength(20)
                .HasColumnName("c_id");
            entity.Property(e => e.Count).HasColumnName("count");
            entity.Property(e => e.GroupId).HasColumnName("group_id");
            entity.Property(e => e.TicketId)
                .HasMaxLength(20)
                .HasColumnName("ticket_id");
            entity.Property(e => e.Totalprice)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("totalprice");

            entity.HasOne(d => d.CIdNavigation).WithMany(p => p.CartDetails)
                .HasForeignKey(d => d.CId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Cart_Detail_Cart");

            entity.HasOne(d => d.Group).WithMany(p => p.CartDetails)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Cart_Detail_ComboGroup");

            entity.HasOne(d => d.Ticket).WithMany(p => p.CartDetails)
                .HasForeignKey(d => d.TicketId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Cart_Detail_Ticket");
        });

        modelBuilder.Entity<ComboGroup>(entity =>
        {
            entity.HasKey(e => e.GroupId).HasName("PK_ComboGroup_1");

            entity.ToTable("ComboGroup");

            entity.Property(e => e.GroupId)
                .ValueGeneratedNever()
                .HasColumnName("group_id");
            entity.Property(e => e.BuildDate)
                .HasColumnType("datetime")
                .HasColumnName("build_date");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<ComboGroupDetail>(entity =>
        {
            entity.HasKey(e => e.SerialId).HasName("PK_ComboGroup_detail");

            entity.ToTable("ComboGroup_Detail");

            entity.Property(e => e.SerialId).HasColumnName("serial_id");
            entity.Property(e => e.GroupId).HasColumnName("group_id");
            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasColumnName("p_id");

            entity.HasOne(d => d.Group).WithMany(p => p.ComboGroupDetails)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ComboGroup_detail_ComboGroup_detail");

            entity.HasOne(d => d.PIdNavigation).WithMany(p => p.ComboGroupDetails)
                .HasForeignKey(d => d.PId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ComboGroup_Detail_Product");
        });

        modelBuilder.Entity<Coupon>(entity =>
        {
            entity.ToTable("Coupon");

            entity.Property(e => e.CouponId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getCouponID]())")
                .HasColumnName("coupon_id");
            entity.Property(e => e.Discount).HasColumnName("discount");
            entity.Property(e => e.DiscountType).HasColumnName("discount_type");
            entity.Property(e => e.ExpirationDate)
                .HasColumnType("datetime")
                .HasColumnName("expiration_date");
            entity.Property(e => e.Name)
                .HasMaxLength(40)
                .HasColumnName("name");
            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasColumnName("p_id");
            entity.Property(e => e.UsableDay).HasColumnName("usable_day");

            entity.HasOne(d => d.PIdNavigation).WithMany(p => p.Coupons)
                .HasForeignKey(d => d.PId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Ticket_Coupon");
        });

        modelBuilder.Entity<CouponList>(entity =>
        {
            entity.ToTable("CouponList");

            entity.Property(e => e.CouponlistId)
                .ValueGeneratedNever()
                .HasColumnName("couponlist_id");
            entity.Property(e => e.CouponId)
                .HasMaxLength(20)
                .HasColumnName("coupon_id");
            entity.Property(e => e.GetDate)
                .HasColumnType("datetime")
                .HasColumnName("get_date");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");

            entity.HasOne(d => d.Coupon).WithMany(p => p.CouponLists)
                .HasForeignKey(d => d.CouponId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CouponList_Coupon");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.CouponLists)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CouponList_Member");
        });

        modelBuilder.Entity<CouponUseRecord>(entity =>
        {
            entity.HasKey(e => e.SerialId);

            entity.ToTable("Coupon_Use_Record");

            entity.Property(e => e.SerialId).HasColumnName("serial_id");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");
            entity.Property(e => e.OrderId)
                .HasMaxLength(20)
                .HasColumnName("order_id");
            entity.Property(e => e.UseDate)
                .HasColumnType("datetime")
                .HasColumnName("use_date");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.CouponUseRecords)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Coupon_Use_Record_Member");

            entity.HasOne(d => d.Order).WithMany(p => p.CouponUseRecords)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Coupon_Use_Record_Order");
        });

        modelBuilder.Entity<DestComment>(entity =>
        {
            entity.HasKey(e => e.CmtId);

            entity.ToTable("Dest_Comment");

            entity.Property(e => e.CmtId)
                .ValueGeneratedNever()
                .HasColumnName("cmt_id");
            entity.Property(e => e.CommentTime)
                .HasColumnType("datetime")
                .HasColumnName("comment_time");
            entity.Property(e => e.Content)
                .HasMaxLength(800)
                .HasColumnName("content");
            entity.Property(e => e.DestId)
                .HasMaxLength(20)
                .HasColumnName("dest_id");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");

            entity.HasOne(d => d.Dest).WithMany(p => p.DestComments)
                .HasForeignKey(d => d.DestId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Dest_Comment_Destination");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.DestComments)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Dest_Comment_Member");
        });

        modelBuilder.Entity<Destination>(entity =>
        {
            entity.HasKey(e => e.DestId);

            entity.ToTable("Destination");

            entity.Property(e => e.DestId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getDestID]())")
                .HasColumnName("dest_id");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.County)
                .HasMaxLength(20)
                .HasColumnName("county");
            entity.Property(e => e.Desc)
                .HasMaxLength(300)
                .HasColumnName("desc");
            entity.Property(e => e.Image)
                .HasMaxLength(200)
                .HasColumnName("image");
            entity.Property(e => e.Latitude)
                .HasColumnType("decimal(18, 10)")
                .HasColumnName("latitude");
            entity.Property(e => e.Longitude)
                .HasColumnType("decimal(18, 10)")
                .HasColumnName("longitude");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.OffShelf)
                .HasColumnType("datetime")
                .HasColumnName("off_shelf");
            entity.Property(e => e.OnShelf)
                .HasColumnType("datetime")
                .HasColumnName("on_shelf");
            entity.Property(e => e.Phone)
                .HasMaxLength(16)
                .HasColumnName("phone");
            entity.Property(e => e.Type).HasColumnName("type");
            entity.Property(e => e.Url)
                .HasMaxLength(300)
                .HasColumnName("url");
        });

        modelBuilder.Entity<Member>(entity =>
        {
            entity.HasKey(e => e.MId);

            entity.ToTable("Member");

            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getMemberID]())")
                .HasColumnName("m_id");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.Birthday)
                .HasColumnType("date")
                .HasColumnName("birthday");
            entity.Property(e => e.BonusPoint).HasColumnName("bonus_point");
            entity.Property(e => e.Credit)
                .HasMaxLength(30)
                .HasColumnName("credit");
            entity.Property(e => e.Email)
                .HasMaxLength(80)
                .HasColumnName("email");
            entity.Property(e => e.Favorite)
                .HasMaxLength(900)
                .HasColumnName("favorite");
            entity.Property(e => e.LastLoginDate)
                .HasColumnType("datetime")
                .HasColumnName("last_login_date");
            entity.Property(e => e.Name)
                .HasMaxLength(20)
                .HasColumnName("name");
            entity.Property(e => e.Password)
                .HasMaxLength(20)
                .HasColumnName("password");
            entity.Property(e => e.Phone)
                .HasMaxLength(16)
                .HasColumnName("phone");
            entity.Property(e => e.RegisterDate)
                .HasColumnType("datetime")
                .HasColumnName("register_date");
            entity.Property(e => e.Sex).HasColumnName("sex");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.ToTable("Order");

            entity.Property(e => e.OrderId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getOrderID]())")
                .HasColumnName("order_id");
            entity.Property(e => e.Count).HasColumnName("count");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");
            entity.Property(e => e.Orderdate)
                .HasColumnType("datetime")
                .HasColumnName("orderdate");
            entity.Property(e => e.OrderdateEnd)
                .HasColumnType("datetime")
                .HasColumnName("orderdate_end");
            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasColumnName("p_id");
            entity.Property(e => e.State).HasColumnName("state");
            entity.Property(e => e.Totalprice)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("totalprice");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Order_Member");

            entity.HasOne(d => d.PIdNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.PId)
                .HasConstraintName("FK_Order_Product");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.OdId);

            entity.ToTable("Order_Detail");

            entity.Property(e => e.OdId).HasColumnName("od_id");
            entity.Property(e => e.GroupId).HasColumnName("group_id");
            entity.Property(e => e.OrderId)
                .HasMaxLength(20)
                .HasColumnName("order_id");
            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasColumnName("p_id");
            entity.Property(e => e.Type).HasColumnName("type");

            entity.HasOne(d => d.Group).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Order_Detail_ComboGroup");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Order_Detail_Order");

            entity.HasOne(d => d.PIdNavigation).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.PId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Order_Detail_Product");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.PId);

            entity.ToTable("Product");

            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getProductID]())")
                .HasColumnName("p_id");
            entity.Property(e => e.Desc)
                .HasMaxLength(300)
                .HasColumnName("desc");
            entity.Property(e => e.DiscountPrice)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("discount_price");
            entity.Property(e => e.GroupId).HasColumnName("group_id");
            entity.Property(e => e.Image)
                .HasMaxLength(200)
                .HasColumnName("image");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.OffShelf)
                .HasColumnType("datetime")
                .HasColumnName("off_shelf");
            entity.Property(e => e.OnShelf)
                .HasColumnType("datetime")
                .HasColumnName("on_shelf");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("price");
            entity.Property(e => e.State).HasColumnName("state");
            entity.Property(e => e.StockNumber).HasColumnName("stock_number");
            entity.Property(e => e.TicketId)
                .HasMaxLength(20)
                .HasColumnName("ticket_id");

            entity.HasOne(d => d.Group).WithMany(p => p.Products)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Product_ComboGroup");

            entity.HasOne(d => d.Ticket).WithMany(p => p.Products)
                .HasForeignKey(d => d.TicketId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Product_Ticket");
        });

        modelBuilder.Entity<ProductComment>(entity =>
        {
            entity.HasKey(e => e.CmtId);

            entity.ToTable("Product_Comment");

            entity.Property(e => e.CmtId)
                .ValueGeneratedNever()
                .HasColumnName("cmt_id");
            entity.Property(e => e.CommentTime)
                .HasColumnType("datetime")
                .HasColumnName("comment_time");
            entity.Property(e => e.Content)
                .HasMaxLength(800)
                .HasColumnName("content");
            entity.Property(e => e.MId)
                .HasMaxLength(20)
                .HasColumnName("m_id");
            entity.Property(e => e.PId)
                .HasMaxLength(20)
                .HasColumnName("p_id");
            entity.Property(e => e.Rating).HasColumnName("rating");

            entity.HasOne(d => d.MIdNavigation).WithMany(p => p.ProductComments)
                .HasForeignKey(d => d.MId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Product_Comment_Member");

            entity.HasOne(d => d.PIdNavigation).WithMany(p => p.ProductComments)
                .HasForeignKey(d => d.PId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Product_Comment_Product");
        });

        modelBuilder.Entity<Staff>(entity =>
        {
            entity.HasKey(e => e.SId);

            entity.Property(e => e.SId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getStaffID]())")
                .HasColumnName("s_id");
            entity.Property(e => e.Account)
                .HasMaxLength(40)
                .HasColumnName("account");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.Birthday)
                .HasColumnType("date")
                .HasColumnName("birthday");
            entity.Property(e => e.DateOfEmployment)
                .HasColumnType("date")
                .HasColumnName("date_of_employment");
            entity.Property(e => e.Department).HasColumnName("department");
            entity.Property(e => e.Email)
                .HasMaxLength(80)
                .HasColumnName("email");
            entity.Property(e => e.IdNumber)
                .HasMaxLength(20)
                .HasColumnName("id_number");
            entity.Property(e => e.Image)
                .HasMaxLength(200)
                .HasColumnName("image");
            entity.Property(e => e.JobPosition).HasColumnName("job_position");
            entity.Property(e => e.LineManager)
                .HasMaxLength(20)
                .HasColumnName("line_manager");
            entity.Property(e => e.Name)
                .HasMaxLength(20)
                .HasColumnName("name");
            entity.Property(e => e.Password)
                .HasMaxLength(20)
                .HasColumnName("password");
            entity.Property(e => e.Phone)
                .HasMaxLength(16)
                .HasColumnName("phone");
            entity.Property(e => e.Salary)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("salary");
            entity.Property(e => e.Sex).HasColumnName("sex");
            entity.Property(e => e.State).HasColumnName("state");
            entity.Property(e => e.TerminationDate)
                .HasColumnType("date")
                .HasColumnName("termination_date");
        });

        modelBuilder.Entity<Supplier>(entity =>
        {
            entity.ToTable("Supplier");

            entity.Property(e => e.SupplierId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getSupplierID]())")
                .HasColumnName("supplier_id");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.County)
                .HasMaxLength(20)
                .HasColumnName("county");
            entity.Property(e => e.Email)
                .HasMaxLength(80)
                .HasColumnName("email");
            entity.Property(e => e.Name)
                .HasMaxLength(40)
                .HasColumnName("name");
            entity.Property(e => e.Phone)
                .HasMaxLength(16)
                .HasColumnName("phone");
        });

        modelBuilder.Entity<Ticket>(entity =>
        {
            entity.ToTable("Ticket");

            entity.Property(e => e.TicketId)
                .HasMaxLength(20)
                .HasDefaultValueSql("([dbo].[getTicketID]())")
                .HasColumnName("ticket_id");
            entity.Property(e => e.Capacity).HasColumnName("capacity");
            entity.Property(e => e.Deadline)
                .HasColumnType("datetime")
                .HasColumnName("deadline");
            entity.Property(e => e.Desc)
                .HasMaxLength(300)
                .HasColumnName("desc");
            entity.Property(e => e.DestId)
                .HasMaxLength(20)
                .HasColumnName("dest_id");
            entity.Property(e => e.DiscountPrice)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("discount_price");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.OffShelf)
                .HasColumnType("datetime")
                .HasColumnName("off_shelf");
            entity.Property(e => e.OnShelf)
                .HasColumnType("datetime")
                .HasColumnName("on_shelf");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("price");
            entity.Property(e => e.State).HasColumnName("state");
            entity.Property(e => e.StockNumber).HasColumnName("stock_number");
            entity.Property(e => e.SupplierId)
                .HasMaxLength(20)
                .HasColumnName("supplier_id");
            entity.Property(e => e.Type).HasColumnName("type");

            entity.HasOne(d => d.Dest).WithMany(p => p.Tickets)
                .HasForeignKey(d => d.DestId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Ticket_Destination");

            entity.HasOne(d => d.Supplier).WithMany(p => p.Tickets)
                .HasForeignKey(d => d.SupplierId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Ticket_Supplier");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
