using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.Identity.Client;
using Microsoft.IdentityModel.Tokens;
using System.Linq;
using System.Text.RegularExpressions;
using TixlorerCore.Models;

using TixlorerCore.ViewModels;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;

namespace TixlorerCore.Controllers
{
    public class ProductController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        //分頁功能

        //進入產品資料頁面

        [HttpPost]
        public ActionResult List(SearchItemViewModel vm)
        {
            // 當使用者提交查詢時，我們將頁碼設置為 1。
            return RedirectToAction("List", new { vm = vm, page = 1 });
        }

        [HttpGet]
        public ActionResult List(SearchItemViewModel vm, int? page)
        {
            //建立資料庫實體
            TixplorerContext db = new TixplorerContext();

            string selectItem = vm.selectItem;//使用者選擇的票券類別
            ViewBag.SelectedSelectItem = selectItem;

            string keyword = vm.txtKeyword; //使用者輸入的關鍵字
            ViewBag.txtKeyword = keyword;

            //預設查詢所有商品
            IEnumerable<Product> datas = db.Products.Where(p => p.GroupId == null);

            ///////////////////分頁功能

            int datasCount = datas.Count();// 計算單票商品所有數量

            int datasPerPage = 10; //每頁顯示的資料筆數

            int pagesCount = 10; //預設顯示10頁

            int pageNumber = page ?? 1; //若page有值則用該值，否則使用1

            int datasToSkip = datasPerPage * (pageNumber - 1); //按下下一頁需跳過的資料筆數

            ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view



            //根據使用者輸入的類別進行篩選，預設為selectItem==4，即「全部」類別
            if (vm.selectItem.IsNullOrEmpty())
            {
                vm.selectItem = "4";
            }

            #region  switch版查詢
            //動態改變分頁數量

            //if (string.IsNullOrEmpty(keyword)) //沒有輸入關鍵字
            //{
            //    switch (ViewBag.SelectedSelectItem)
            //    {
            //        case "0":

            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where t.Type == 0
            //                     orderby p.PId 
            //                     select p)
            //               .Skip(datasToSkip)
            //               .Take(datasPerPage)
            //               .ToList();

            //            datasCount = datas.Count();

            //            break;
            //        case "1":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where t.Type == 1
            //                     orderby p.PId
            //                     select p)
            //           .Skip(datasToSkip)
            //           .Take(datasPerPage)
            //           .ToList();

            //            datasCount = datas.Count();
            //            break;
            //        case "2":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where t.Type == 2
            //                     orderby p.PId
            //                     select p)
            //               .Skip(datasToSkip)
            //               .Take(datasPerPage)
            //               .ToList();

            //            datasCount = datas.Count();
            //            break;
            //        case "3":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where t.Type == 3
            //                     orderby p.PId
            //                     select p)
            //               .Skip(datasToSkip)
            //               .Take(datasPerPage)
            //               .ToList();

            //            datasCount = datas.Count();
            //            break;
            //        default:
            //            datas = db.Products.Where(p => p.GroupId == null);
            //            datasCount = datas.Count();  // 計算單票商品所有數量
            //            break;
            //    }
            //}
            //else
            //{
            //    switch (ViewBag.SelectedSelectItem)
            //    {
            //        case "0":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where p.Name.Contains(keyword) && (t.Type == 0)
            //                     select p)
            //                .Skip(datasToSkip)
            //                .Take(datasPerPage)
            //                .ToList();
            //            datasCount = datas.Count();
            //            break;
            //        case "1":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where p.Name.Contains(keyword) && (t.Type == 1)
            //                     select p)
            //                    .Skip(datasToSkip)
            //                    .Take(datasPerPage)
            //                    .ToList();
            //              datasCount=datas.Count();
            //            break;
            //        case "2":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where p.Name.Contains(keyword) && (t.Type == 2)
            //                     select p)
            //                    .Skip(datasToSkip)
            //                    .Take(datasPerPage)
            //                    .ToList();
            //            datasCount = datas.Count();
            //            break;
            //        case "3":
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where p.Name.Contains(keyword) && (t.Type == 3)
            //                     select p)
            //                    .Skip(datasToSkip)
            //                    .Take(datasPerPage)
            //                    .ToList();
            //            datasCount = datas.Count();
            //            break;
            //        default:
            //            datas = (from p in db.Products
            //                     join t in db.Tickets on p.TicketId equals t.TicketId
            //                     where p.Name.Contains(keyword) && (p.GroupId == null)
            //                     select p)
            //                    .Skip(datasToSkip)
            //                    .Take(datasPerPage)
            //                    .ToList();
            //            datasCount = datas.Count();  //計算單票商品所有數量
            //            break;
            //    }
            //}

            #endregion


            #region 分頁測試
            //測試分頁數量用
            //var datasCount = (from p in db.Products
            //                  join t in db.Tickets on p.TicketId equals t.TicketId
            //                  where t.Type == 1
            //                  orderby p.PId //根據PId排序
            //                  select p)
            //             .Count();
            #endregion


            #region 查詢功能
            if (selectItem == "0" || selectItem == "1" || selectItem == "2" || selectItem == "3")
            {
                //沒有輸入關鍵字
                if (string.IsNullOrEmpty(keyword))
                {

                    //查詢使用者選擇的類別的所有結果
                    datas = (from p in db.Products
                             join t in db.Tickets on p.TicketId equals t.TicketId
                             where t.Type == Convert.ToInt32(selectItem)
                             orderby p.PId //根據PId排序
                             select p)
                            .Skip(datasToSkip)
                            .Take(datasPerPage)
                            .ToList();


                    datasCount = (from p in db.Products
                                  join t in db.Tickets on p.TicketId equals t.TicketId
                                  where t.Type == Convert.ToInt32(selectItem)
                                  select p)
                                 .Count();

                    pagesCount = (int)Math.Ceiling((double)datasCount / datasPerPage);//計算總共的分頁數
                    ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view
                }
                //有輸入關鍵字
                else
                {
                    //datas = db.Products.Where(p => p.Name.Contains(keyword) && (p.GroupId == Convert.ToInt32(selectItem)));

                    //查詢類別內所有包含關鍵字的結果
                    datas = (from p in db.Products
                             join t in db.Tickets on p.TicketId equals t.TicketId
                             where p.Name.Contains(keyword) && (t.Type == Convert.ToInt32(selectItem))
                             orderby p.PId
                             select p)
                            .Skip(datasToSkip)
                            .Take(datasPerPage)
                            .ToList();

                    datasCount = (from p in db.Products
                                  join t in db.Tickets on p.TicketId equals t.TicketId
                                  where p.Name.Contains(keyword) && (t.Type == Convert.ToInt32(selectItem))
                                  select p)
                             .Count();

                    pagesCount = (int)Math.Ceiling((double)datasCount / datasPerPage);//計算總共的分頁數
                    ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view
                }
            }
            else //選擇"全部"類別
            {
                //沒有輸入關鍵字
                if (string.IsNullOrEmpty(keyword))
                {
                    //datas = db.Products;

                    //查詢所有單票
                    //datas = db.Products.Where(p => p.GroupId == null)


                    //查詢使用者選擇的類別的所有結果
                    datas = (from p in db.Products
                             where p.GroupId == null
                             orderby p.PId //根據PId排序
                             select p)
                            .Skip(datasToSkip)
                            .Take(datasPerPage)
                            .ToList();

                    datasCount = (from p in db.Products
                                  join t in db.Tickets on p.TicketId equals t.TicketId
                                  where p.GroupId == null
                                  select p)
                                  .Count();

                    pagesCount = (int)Math.Ceiling((double)datasCount / datasPerPage);//計算總共的分頁數
                    ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view
                }
                //有輸入關鍵字
                else
                {
                    //datas = db.Products.Where(p => p.Name.Contains(keyword));

                    //查詢所有包含關鍵字的單票結果
                    //datas = db.Products.Where(p => (p.GroupId == null) && p.Name.Contains(keyword));

                    datas = (from p in db.Products
                             where (p.GroupId == null) && p.Name.Contains(keyword)
                             orderby p.PId
                             select p)
                            .Skip(datasToSkip)
                            .Take(datasPerPage)
                            .ToList();

                    datasCount = (from p in db.Products
                                  where (p.GroupId == null) && p.Name.Contains(keyword)
                                  select p)
                                  .Count();
                    pagesCount = (int)Math.Ceiling((double)datasCount / datasPerPage);//計算總共的分頁數
                    ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view
                }
            }


            #region 查詢無結果時的判斷
            //判斷查詢是否有結果，若查無資料，則查詢所有結果，並清除搜尋框。(選擇的類別會保留)
            if (datasCount == 0)
            {
                ViewBag.NoDataFound = true;
                ViewBag.txtKeyword = "";
                
                if (selectItem == "0" || selectItem == "1" || selectItem == "2" || selectItem == "3")
                {
                        //查詢使用者選擇的類別的所有結果
                        datas = (from p in db.Products
                                 join t in db.Tickets on p.TicketId equals t.TicketId
                                 where t.Type == Convert.ToInt32(selectItem)
                                 orderby p.PId //根據PId排序
                                 select p)
                                .Skip(datasToSkip)
                                .Take(datasPerPage)
                                .ToList();

                        datasCount = (from p in db.Products
                                      join t in db.Tickets on p.TicketId equals t.TicketId
                                      where t.Type == Convert.ToInt32(selectItem)
                                      select p)
                                     .Count();

                        pagesCount = (int)Math.Ceiling((double)datasCount / datasPerPage);//計算總共的分頁數
                        ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view
                }
                else
                {
                    datas = (from p in db.Products
                             where p.GroupId == null
                             orderby p.PId //根據PId排序
                             select p)
                            .Skip(datasToSkip)
                            .Take(datasPerPage)
                            .ToList();

                    datasCount = (from p in db.Products
                                  join t in db.Tickets on p.TicketId equals t.TicketId
                                  where p.GroupId == null
                                  select p)
                                  .Count();

                    pagesCount = (int)Math.Ceiling((double)datasCount / datasPerPage);//計算總共的分頁數
                    ViewBag.TotalPages = pagesCount; //把計算完的頁數傳給view
                }

            }
            #endregion

            DropdownList();  //執行「建立下拉式選單」

            ViewBag.CurrentPage = page ?? 1;

            ViewBag.selectedPage = 1;
            return View(datas);
        }
        #endregion


        #region 建立分類下拉選單()
        public void DropdownList()
        {
            List<SelectListItem> selectItem = new List<SelectListItem>();
            selectItem.Add(new SelectListItem { Text = "全部", Value = "4" });
            selectItem.Add(new SelectListItem { Text = "活動", Value = "0" });
            selectItem.Add(new SelectListItem { Text = "景點", Value = "1" });
            selectItem.Add(new SelectListItem { Text = "飯店", Value = "2" });
            selectItem.Add(new SelectListItem { Text = "餐廳", Value = "3" });
            ViewBag.selectItem = selectItem;
        }
        #endregion

        //新增商品功能
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(Product t)
        {
            string tmpPID = string.Empty;
            TixplorerContext db = new TixplorerContext();
            tmpPID = t.PId;

            db.Products.Add(t);
            db.SaveChanges();
            return RedirectToAction("List");
        }

        //刪除商品功能
        public ActionResult Delete(string id)
        {
            if (id != null)
            {
                TixplorerContext db = new TixplorerContext();
                Product product = db.Products.FirstOrDefault(p => p.PId == id);
                if (product != null)
                {
                    db.Products.Remove(product);
                    db.SaveChanges();
                }
            }
            return RedirectToAction("List");
        }

        //修改商品功能(尚未加入上傳圖片功能)

        public ActionResult Edit(string id)
        {
            if (id == null)
                return RedirectToAction("List");
            TixplorerContext db = new TixplorerContext();
            Product prod = db.Products.FirstOrDefault(p => p.PId == id);
            return View(prod);
        }
        [HttpPost]
        public ActionResult Edit(Product x)
        {
            TixplorerContext db = new TixplorerContext();
            Product prod = db.Products.FirstOrDefault(p => p.PId == x.PId);
            if (prod != null)
            {

                prod.Name = x.Name;
                prod.TicketId = x.TicketId;
                prod.GroupId = x.GroupId;
                prod.Price = x.Price;
                prod.DiscountPrice = x.DiscountPrice;
                prod.Desc = x.Desc;
                prod.Image = x.Image;
                prod.StockNumber = x.StockNumber;
                prod.OnShelf = x.OnShelf;
                prod.OffShelf = x.OffShelf;
                prod.State = x.State;
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }

    }
}
