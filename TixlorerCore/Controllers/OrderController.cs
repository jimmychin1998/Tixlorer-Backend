using Microsoft.AspNetCore.Mvc;
using TixlorerCore.Models;
using TixlorerCore.TicketViewModels;
using TixlorerCore.ViewModels;

namespace TixlorerCore.Controllers
{
    public class OrderController : Controller
    {
        public ActionResult List(OrderKeywordVM vm)
        {
            string OrderKeyword = vm.OrderKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<Order> datas = null;
            if (string.IsNullOrEmpty(OrderKeyword))
            {
                datas = from p in db.Orders
                        select p;
            }
            else
                datas = db.Orders.Where(p => p.OrderId.Contains(OrderKeyword)||p.MId.Contains(OrderKeyword));
            return View(datas);
        }

        public ActionResult Edit(string? id)
        {
            if (id == null)
                return RedirectToAction("List");
            TixplorerContext db = new TixplorerContext();
            Order prod = db.Orders.FirstOrDefault(p => p.OrderId == id);
            return View(prod);
        }
        [HttpPost]
        public ActionResult Edit(Order x)
        {
            TixplorerContext db = new TixplorerContext();
            Order prod = db.Orders.FirstOrDefault(p => p.OrderId == x.OrderId);
            if (prod != null)
            {
                prod.MId = x.MId;
                prod.Totalprice = x.Totalprice;
                prod.Orderdate = x.Orderdate;
                prod.OrderdateEnd = x.OrderdateEnd;
                prod.State = x.State;
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }
        public ActionResult defail(string? id)
        {
            if (id == null)
                return RedirectToAction("List");
            TixplorerContext db = new TixplorerContext();
            OrderDetail prod = db.OrderDetails.FirstOrDefault(p => p.OrderId == id);
            return View(prod);
        }
        public ActionResult Delete(string? id)
        {
            if (id != null)
            {
                TixplorerContext db = new TixplorerContext();
                Order prod = db.Orders.FirstOrDefault(p => p.OrderId == id);
                if (prod != null)
                {
                    db.Orders.Remove(prod);
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
        public ActionResult Create(Order t)
        {
            TixplorerContext db = new TixplorerContext();
            Member Mid = db.Members.FirstOrDefault(m => m.MId == t.MId);
            if (Mid == null)
                return View();
            db.Orders.Add(t);
            db.SaveChanges();
            return RedirectToAction("List");
        }
    }
}
