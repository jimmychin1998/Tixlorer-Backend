using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using TixlorerCore.Models;
using TixlorerCore.TicketViewModels;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace TixlorerCore.Controllers
{
    public class TicketController : Controller
    {
        public IActionResult List(TicketViewModel viewmodel)
        {
            string keyword = viewmodel.txtTicketKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<Ticket> datas = null;
            if (string.IsNullOrEmpty(keyword))
            {
                datas = from p in db.Tickets
                        select p;
            }
            else
            {
                datas = db.Tickets.Where(p => p.Name.Contains(keyword)
                //||
                //p.FPhone.Contains(keyword) ||
                //p.FEmail.Contains(keyword) ||
                //p.FAddress.Contains(keyword)
                );
            }
             
            return View(datas);
        }

        public ActionResult Edit(string? id)
        {
            if (id == null)
            return RedirectToAction("List");
            TixplorerContext db = new TixplorerContext();

			//Ticket Tic = db.Tickets.FirstOrDefault(p => p.TicketId == id);
			//return View(Tic);
			
            TicketViewModel viewModel = new TicketViewModel();
			viewModel.Tic = db.Tickets.FirstOrDefault(p => p.TicketId == id);
			viewModel.DestIds = db.Destinations.Select(d => d.DestId).ToList();
            viewModel.SupplierIds = db.Suppliers.Select(d => d.SupplierId).ToList();
            return View(viewModel);
		}
        [HttpPost]
        public ActionResult Edit(TicketViewModel x)
        {
            TixplorerContext db = new TixplorerContext();
            Ticket Tic = db.Tickets.FirstOrDefault(p => p.TicketId == x.Tic.TicketId);

            bool Validate = ValidateTicket(x);  //確認資料是否填寫有誤的自創方法
            
            if (Tic != null && Validate == true)
            {
                Tic.TicketId = x.Tic.TicketId;
                Tic.DestId = x.Tic.DestId;
                Tic.Name = x.Tic.Name;
                Tic.Type = x.Tic.Type;
                Tic.Capacity = x.Tic.Capacity;
                Tic.Price = x.Tic.Price;
                Tic.DiscountPrice = x.Tic.DiscountPrice;
                Tic.Deadline = x.Tic.Deadline;
                Tic.Desc = x.Tic.Desc;
                Tic.StockNumber = x.Tic.StockNumber;
                Tic.OnShelf = x.Tic.OnShelf;
                Tic.OffShelf = x.Tic.OffShelf;
                Tic.SupplierId = x.Tic.SupplierId;
                Tic.State = x.Tic.State;
                if (x.Tic.StockNumber == 0)  //若庫存為0將票券狀態更改為2(已下架)
                {
                    Tic.State = 2;       
                }
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }

        public ActionResult Delete(string? id)
        {
            if (id != null)
            {
                TixplorerContext db = new TixplorerContext();
                Ticket Tic = db.Tickets.FirstOrDefault(p => p.TicketId == id);
                if (Tic != null)
                {
                    db.Tickets.Remove(Tic);
                    db.SaveChanges();
                }
            }
            return RedirectToAction("List");
        }
        
        public ActionResult Create()
        {
            TixplorerContext db = new TixplorerContext();
            TicketViewModel viewModel = new TicketViewModel();
            viewModel.DestIds = db.Destinations.Select(d => d.DestId).ToList();
            viewModel.SupplierIds = db.Suppliers.Select(d => d.SupplierId).ToList();
            return View(viewModel);
        }
        [HttpPost]
        public ActionResult Create(TicketViewModel x)
        {
            TixplorerContext db = new TixplorerContext();

            bool Validate = ValidateTicket(x); //確認資料是否填寫有誤的自創方法

            if (Validate == true)
            {
                if (x.Tic.StockNumber == 0)  //若庫存為0將票券狀態更改為2(已下架)
                {
                    x.Tic.State = 2;
                }
                db.Tickets.Add(x.Tic);
                db.SaveChanges();
            }               
            return RedirectToAction("List");
        }      

        public bool ValidateTicket(TicketViewModel x)
        {
            TixplorerContext db = new TixplorerContext();

            bool destIdExists = true;
            if (x.Tic.DestId == "null")
            {
                x.Tic.DestId = null;
            }
            if (!string.IsNullOrEmpty(x.Tic.DestId))
            {
                destIdExists = db.Destinations.Any(t => t.DestId == x.Tic.DestId);
            }
            //確認輸入之DestId是否在Destinations已存在(外來鍵)

            bool supplierIdExists = true;
            if (x.Tic.SupplierId == "null")
            {
                x.Tic.SupplierId = null;
            }
            if (!string.IsNullOrEmpty(x.Tic.SupplierId))
            {
                supplierIdExists = db.Suppliers.Any(t => t.SupplierId == x.Tic.SupplierId);
            }
            //確認輸入之SupplierId是否在Suppliers已存在(外來鍵)

            bool checkType = CheckTypeValue(x.Tic.Type);
            //確保Type(票券類型)只會有0,1,2,3四種數字的方法

            bool checkState = CheckStateValue((int)x.Tic.State);
            //確保State(票券狀態)只會有0,1,2三種數字的方法

            bool CapacityNonNegative = IntIsNonNegative(x.Tic.Capacity);
            //確認Capacity(票券人數)是否為負數

            bool StockNumberNonNegative = IntIsNonNegative(x.Tic.StockNumber);
            //確認StockNumber(票券庫存量)是否為負數

            bool PriceNonNegative = decimalIsNonNegative(x.Tic.Price);
            //確認Price(價格)是否為負數

            bool DiscountPriceNonNegative = true;
            if (x.Tic.DiscountPrice != null)
            {
                DiscountPriceNonNegative = decimalIsNonNegative(x.Tic.DiscountPrice);
            }
            //若DiscountPrice(折扣後價格)不為null，確認其數值是否為負數

            bool TimeConfirm = true;
            if (x.Tic.OnShelf != null && x.Tic.OffShelf != null)
            {
                TimeConfirm = TimeCompare(x.Tic.OnShelf, x.Tic.OffShelf);
            }
            //若上下架時間都不為null，確認下架時間是否在上架時間之後

            return destIdExists && supplierIdExists && checkType && checkState && CapacityNonNegative
               && StockNumberNonNegative && PriceNonNegative && DiscountPriceNonNegative && TimeConfirm;
        }

        /*
        public bool ValidateTicket(Ticket x)
        {
            TixplorerContext db = new TixplorerContext();
            bool destIdExists = db.Destinations.Any(t => t.DestId == x.DestId);
            //確認輸入之DestId是否在Destinations已存在(外來鍵)
           
            bool supplierIdExists = db.Suppliers.Any(t => t.SupplierId == x.SupplierId);
            //確認輸入之SupplierId是否在Suppliers已存在(外來鍵)
            
            bool checkType = CheckTypeValue(x.Type);
            //確保Type(票券類型)只會有0,1,2,3四種數字的方法
            
            bool checkState = CheckStateValue(x.State);
            //確保State(票券狀態)只會有0,1,2三種數字的方法
            
            bool CapacityNonNegative = IntIsNonNegative(x.Capacity);
            //確認Capacity(票券人數)是否為負數
           
            bool StockNumberNonNegative = IntIsNonNegative(x.StockNumber);
            //確認StockNumber(票券庫存量)是否為負數
            
            bool PriceNonNegative = decimalIsNonNegative(x.Price);
            //確認Price(價格)是否為負數
            
            bool DiscountPriceNonNegative = true;  
            if (x.DiscountPrice != null)
            {
                DiscountPriceNonNegative = decimalIsNonNegative(x.DiscountPrice);
            }
            //若DiscountPrice(折扣後價格)不為null，確認其數值是否為負數

            bool TimeConfirm = false;
            if (x.OnShelf != null && x.OffShelf != null)
            {
                TimeConfirm = TimeCompare(x.OnShelf, x.OffShelf);
            }
            //若上下架時間都不為null，確認下架時間是否在上架時間之後

            return destIdExists && supplierIdExists && checkType && checkState && CapacityNonNegative
               && StockNumberNonNegative && PriceNonNegative && DiscountPriceNonNegative && TimeConfirm;
        }
        */

        public bool CheckTypeValue(int value)    //確保Type(票券類型)只會有0,1,2,3四種數字的方法
        {
            int[] values = { 0, 1, 2, 3 };
            return values.Contains(value);
        }

        public bool CheckStateValue(int value)   //確保State(票券狀態)只會有0,1,2三種數字的方法
        {
            int[] values = { 0, 1, 2 };
            return values.Contains(value);
        }

        public bool IntIsNonNegative(int number)    //確認int數值是否為負數，是負數就回傳false，是正數就回傳true
        {
            return number < 0 ? false : true;
        }

        public bool decimalIsNonNegative(decimal? number)    //確認decimal數值是否為負數，是負數就回傳false，是正數就回傳true
        {
            return number < 0 ? false : true;
        }

        public bool TimeCompare(DateTime? OnShelf , DateTime? OffShelf)    //確認下架時間是否在上架時間之後
        {
            return OffShelf > OnShelf ? true : false;
        }
    }
}
