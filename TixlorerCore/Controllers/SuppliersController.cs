using Microsoft.AspNetCore.Mvc;
using TixlorerCore.Models;
using WebApplication2.ViewModels;

namespace TTixlorerCore.Controllers
{
    public class SuppliersController : Controller
    {
        public ActionResult List(SupplierskeywordVM vm)
        {
            string keyword = vm.Keyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<Supplier> datas = null;
            if (string.IsNullOrEmpty(keyword))
            {
                datas = from p in db.Suppliers
                        select p;
            }
            else
                datas = db.Suppliers.Where(p => p.SupplierId.Contains(keyword) || p.Name.Contains(keyword)|| p.Phone.Contains(keyword) || p.Email.Contains(keyword) || p.Address.Contains(keyword)||p.County.Contains(keyword));
            return View(datas);
        }

        public ActionResult Edit(string? id)
        {
            if (id == null)
                return RedirectToAction("List");
            TixplorerContext db = new TixplorerContext();
            Supplier prod = db.Suppliers.FirstOrDefault(p => p.SupplierId == id);
            return View(prod);
        }
        [HttpPost]
        public ActionResult Edit(Supplier x)
        {
            TixplorerContext db = new TixplorerContext();
            Supplier prod = db.Suppliers.FirstOrDefault(p => p.SupplierId == x.SupplierId);
            if (prod != null)
            {
                prod.SupplierId = x.SupplierId;
                prod.Name = x.Name;
                prod.Phone = x.Phone;
                prod.Email = x.Email;
                prod.County = x.County;
                prod.Address = x.Address;
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }

        public ActionResult Delete(string? id)
        {
            if (id != null)
            {
                TixplorerContext db = new TixplorerContext();
                Supplier prod = db.Suppliers.FirstOrDefault(p => p.SupplierId == id);
                if (prod != null)
                {
                    db.Suppliers.Remove(prod);
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
        public ActionResult Create(Supplier t)
        {
            TixplorerContext db = new TixplorerContext();
            db.Suppliers.Add(t);
            db.SaveChanges();
            return RedirectToAction("List");
        }
    }
}
