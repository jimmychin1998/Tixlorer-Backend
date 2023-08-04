using Microsoft.AspNetCore.Components.Server.Circuits;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TixlorerCore.Models;
using TixlorerCore.ViewModels;

namespace TixlorerCore.Controllers
{
    public class CouponUseRecordController : Controller
    {
        public ActionResult List(CouponKeywordVM ckvm)
        {
            string keyword = ckvm.txtKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<CouponUseRecordVM> datas = null;
            if (string.IsNullOrEmpty(keyword))
            {
                datas = (from cur in db.CouponUseRecords
                         join m in db.Members on cur.MId equals m.MId
                         select new CouponUseRecordVM
                         {
                             MId = cur.MId,
                             MName = m.Name,
                             OrderId = cur.OrderId,
                             UseDate = cur.UseDate
                         });
            }
            else
                datas = (from cur in db.CouponUseRecords
                          join m in db.Members on cur.MId equals m.MId
                          where cur.MId == keyword || m.Name == keyword || cur.OrderId == keyword
                          select new CouponUseRecordVM
                          {
                              MId = cur.MId,
                              MName = m.Name,
                              OrderId = cur.OrderId,
                              UseDate = cur.UseDate
                          });

            return View(datas);
        }
    }
}
