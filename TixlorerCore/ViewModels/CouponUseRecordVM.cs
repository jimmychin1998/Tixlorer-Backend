using TixlorerCore.Models;

namespace TixlorerCore.ViewModels
{
    public class CouponUseRecordVM
    {
        public string MId { get; set; }
        public string MName { get; set; }
        public string OrderId { get; set; }
        public DateTime UseDate { get; set; }
    }
}
