using Microsoft.AspNetCore.Mvc;
using System.Reflection.Emit;
using TixlorerCore.Models;
using TixlorerCore.ViewModels;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace TixlorerCore.Controllers
{
    public class BonusPointRecordController : Controller
    {
        public ActionResult List(CouponKeywordVM ckvm)
        {
            string keyword = ckvm.txtKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<BonusPointRecordVM> datas = null;
            
            if (string.IsNullOrEmpty(keyword))
            {

                datas = (from bpr in db.BonusPointRecords
                         join m in db.Members on bpr.MId equals m.MId
                         select new BonusPointRecordVM
                         {
                             MId = bpr.MId,
                             MName = m.Name,
                             BonusPoint = bpr.BonusPoint,
                             OperateType = bpr.OperateType,
                             Date = bpr.Date,
                             OrderId = bpr.OrderId,
                             OperateTypeText = bpr.OperateType == 0? "獲得" : "使用"
                         });
            }
            else
                datas = (from bpr in db.BonusPointRecords
                         join m in db.Members on bpr.MId equals m.MId
                         where bpr.MId == keyword || m.Name == keyword || bpr.OrderId == keyword
                         select new BonusPointRecordVM
                         {
                             MId = bpr.MId,
                             MName = m.Name,
                             BonusPoint = bpr.BonusPoint,
                             OperateType = bpr.OperateType,
                             Date = bpr.Date,
                             OrderId = bpr.OrderId,
                             OperateTypeText = bpr.OperateType == 0 ? "獲得" : "使用"
                         });
            return View(datas);
        }
    }
}
