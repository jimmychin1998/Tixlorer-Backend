using Microsoft.AspNetCore.Mvc;
using TixlorerCore.Models;
using TixlorerCore.ViewModels;

namespace TixlorerCore.Controllers
{
    public class CouponController : Controller
    {
        public ActionResult List(CouponKeywordVM vm)
        {
            string keyword = vm.txtKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<Coupon> datas = null;
            if (string.IsNullOrEmpty(keyword))
            {
                datas = from c in db.Coupons
                        select c;
            } else
                datas = db.Coupons.Where(c => c.Name.Contains(keyword)||
                                              c.CouponId.Contains(keyword));
            return View(datas);
        }
        public ActionResult Delete(string? id)
        {
            if (id != null)
            {
                TixplorerContext db = new TixplorerContext();
                Coupon coup = db.Coupons.FirstOrDefault(c => c.CouponId == id);
                if (coup != null)
                {
                    db.Coupons.Remove(coup);
                    db.SaveChanges();
                }
            }
            return RedirectToAction("List");
        }
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(Coupon c)
        {
            TixplorerContext db = new TixplorerContext();
            db.Coupons.Add(c);
            db.SaveChanges();
            return RedirectToAction("List");
        }
        public ActionResult Edit(string? id)
        {
            if (id == null)
                return RedirectToAction("List");
            TixplorerContext db = new TixplorerContext();
            Coupon coup = db.Coupons.FirstOrDefault(c => c.CouponId == id);
            return View(coup);
        }
        [HttpPost]
        public ActionResult Edit(Coupon c)
        {
            TixplorerContext db = new TixplorerContext();
            Coupon coup = db.Coupons.FirstOrDefault(x => x.CouponId == c.CouponId);
            if (coup != null)
            {
                coup.Name = c.Name;
                coup.PId = c.PId;
                coup.DiscountType = c.DiscountType;
                coup.Discount = c.Discount;
                coup.UsableDay = c.UsableDay;
                coup.ExpirationDate = c.ExpirationDate;
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }
    }
}
