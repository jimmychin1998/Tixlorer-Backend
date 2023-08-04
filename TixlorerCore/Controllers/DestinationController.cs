using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.IdentityModel.Tokens;
using TixlorerCore.Models;
using TixlorerCore.ViewModels;

namespace TixlorerCore.Controllers
{
    public class DestinationController : Controller
    {
        private IWebHostEnvironment _enviro = null;
        public DestinationController(IWebHostEnvironment p)
        {
            _enviro = p;
        }
        public IActionResult List(DestnationKeywordVM vm)
        {
            string keyword = vm.txtKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<Destination> datas = null;
            if (vm.txtConditionType == "99" || string.IsNullOrEmpty(vm.txtConditionType))
            {
                //當沒有設定查詢條件時，取得所有目的地資料
                datas = db.Destinations;
            }
            else
            {
                //當有查詢關鍵字時，根據查詢條件和關鍵字查詢指定資料
                datas = ConditionSearch(Convert.ToInt32(vm.txtConditionType), keyword);
            }
            //設置條件查詢下拉選單使用的內容
            ListSearchCategorySet();

            //根據當前選擇欄位進行欄位排序
            datas = sortByItem(datas, vm.sortBy);

            return View(datas);
        }
        public ActionResult Create()
        {
            //設置條件下拉選單使用的內容
            ListCategorySet();

            return View();
        }
        [HttpPost]
        public ActionResult Create(DestinationWrapper item)
        {
            TixplorerContext db = new TixplorerContext();
            //回傳物件item預設值設定
            item = CreateDefault(item);
            db.Destinations.Add(item._destination);
            db.SaveChanges();
            return RedirectToAction("List");
        }

        public ActionResult Edit(string? id)
        {
            if (id == null)
            {
                //編輯資料時若無資料可編輯，則重新回到目的地清單(List)
                return RedirectToAction("List");
            }
            TixplorerContext db = new TixplorerContext();
            var datas = db.Destinations.FirstOrDefault(d=>d.DestId == id);

            //設置條件下拉選單使用的內容
            ListCategorySet();

            return View(datas);
        }
        [HttpPost]
        public ActionResult Edit(DestinationWrapper item)
        {
            TixplorerContext db = new TixplorerContext();
            Destination Dest = db.Destinations.FirstOrDefault(d=>d.DestId == item.DestId);
            if(Dest != null)
            {
                //如果當前資料庫內有修改的目的地編號資料，則開始進行資料修改的存取
                Dest.Name = item.Name;
                Dest.Type = item.Type;
                Dest.County = item.County;
                Dest.Phone = item.Phone;
                Dest.Address = item.Address;
                Dest.Longitude = item.Longitude;
                Dest.Latitude = item.Latitude;
                Dest.Desc = item.Desc;
                Dest.OnShelf = item.OnShelf;
                Dest.OffShelf = item.OffShelf;
                Dest.Url = item.Url;
                //照片修改的資料存取
                if (item.photo != null)
                {//如果上傳照片不為空值時，進行照片路徑的更新作業，並建立新的照片檔案於images內
                    string photoName = Guid.NewGuid().ToString() + ".jpg";
                    item.photo.CopyTo(new FileStream(_enviro.WebRootPath + "/images/DestImages/" + photoName, FileMode.Create));
                    Dest.Image = photoName;
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
                Destination dest = db.Destinations.FirstOrDefault(s => s.DestId == id);
                if (dest != null)
                {
                    db.Destinations.Remove(dest);
                    db.SaveChanges();
                }
            }
            return RedirectToAction("List");
        }

        public ActionResult ListSearchCategorySet()
        {//建置於List畫面中，條件搜尋下拉清單的內容
            List<SelectListItem> listitem = new List<SelectListItem>();
            listitem.Add(new SelectListItem { Text = "不選擇", Value = "99" });
            listitem.Add(new SelectListItem { Text = "活動", Value = "0" });
            listitem.Add(new SelectListItem { Text = "景點", Value = "1" });
            listitem.Add(new SelectListItem { Text = "飯店", Value = "2" });
            listitem.Add(new SelectListItem { Text = "餐廳", Value = "3" });

            ViewBag.ConditionType = listitem;
            return View();
        }

        public ActionResult ListCategorySet()
        {//編輯、新建目的地資料中，下拉清單的內容
            List<SelectListItem> listitem = new List<SelectListItem>();
            listitem.Add(new SelectListItem { Text = "活動", Value = "0" });
            listitem.Add(new SelectListItem { Text = "景點", Value = "1" });
            listitem.Add(new SelectListItem { Text = "飯店", Value = "2" });
            listitem.Add(new SelectListItem { Text = "餐廳", Value = "3" });

            ViewBag.ConditionType = listitem;
            return View();
        }

        private IEnumerable<Destination>? ConditionSearch(int ConditionType, string keyword)
        {//根據條件查詢的選擇產生不同的Linq查詢語法
            IEnumerable<Destination> results = null;
            TixplorerContext db = new TixplorerContext();
            switch (ConditionType)
            {
                case 0://查詢條件為「活動」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Destinations.Where(d => d.Type == 0);
                    else
                        results = db.Destinations.Where(d => d.Type == 0 && d.Name.Contains(keyword));
                    break;
                case 1://查詢條件為「景點」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Destinations.Where(d => d.Type == 1);
                    else
                        results = db.Destinations.Where(d => d.Type == 1 && d.Name.Contains(keyword));
                    break;
                case 2://查詢條件為「飯店」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Destinations.Where(d => d.Type == 2);
                    else
                        results = db.Destinations.Where(d => d.Type == 2 && d.Name.Contains(keyword));
                    break;
                case 3://查詢條件為「餐廳」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Destinations.Where(d => d.Type == 3);
                    else
                        results = db.Destinations.Where(d => d.Type == 3 && d.Name.Contains(keyword));
                    break;
                default:
                    break;
            }
            return results;
        }

        public DestinationWrapper CreateDefault(DestinationWrapper item)
        {//此方法用於建立新建目的地時部分預設值，如「在職狀態」

            //照片修改的資料存取
            if (item.photo != null)
            {//如果上傳照片不為空值時，進行照片路徑的更新作業，並建立新的照片檔案於images內
                string photoName = Guid.NewGuid().ToString() + ".jpg";
                item.photo.CopyTo(new FileStream(_enviro.WebRootPath + "/images/DestImages/" + photoName, FileMode.Create));
                item.Image = photoName;
            }
            else
            {
                //上傳照片若為空值時，預設其值為"NoImage.png"
                item.Image = "NoImage.png";
            }

            return item;
        }

        public IEnumerable<Destination> sortByItem(IEnumerable<Destination> item,string sortBy)
        {//清單排序功能，根據所點選的標題來做升冪、降冪的排序
            ViewBag.sortById = string.IsNullOrEmpty(sortBy) ? "Id_Desc" : "";
            ViewBag.sortByName = sortBy == "Name" ? "Name_Desc" :"Name";
            ViewBag.sortByType = sortBy == "Type" ? "Type_Desc" : "Type";
            ViewBag.sortByCounty = sortBy == "County" ? "County_Desc" : "County";
            ViewBag.sortByOnShelf = sortBy == "OnShelf" ? "OnShelf_Desc" : "OnShelf";
            ViewBag.sortByOffShelf = sortBy == "OffShelf" ? "OffShelf_Desc" : "OffShelf";
            switch (sortBy)
            {
                case "Id_Desc":
                    item = item.OrderByDescending(d => d.DestId);
                    break;
                case "Name":
                    item = item.OrderBy(d => d.Name);
                    break;
                case "Name_Desc":
                    item = item.OrderByDescending(d => d.Name);
                    break;
                case "Type":
                    item = item.OrderBy(d => d.Type);
                    break;
                case "Type_Desc":
                    item = item.OrderByDescending(d => d.Type);
                    break;
                case "County":
                    item = item.OrderBy(d => d.County);
                    break;
                case "County_Desc":
                    item = item.OrderByDescending(d => d.County);
                    break;
                case "OnShelf":
                    item = item.OrderBy(d => d.OnShelf);
                    break;
                case "OnShelf_Desc":
                    item = item.OrderByDescending(d => d.OnShelf);
                    break;
                case "OffShelf":
                    item = item.OrderBy(d => d.OffShelf);
                    break;
                case "OffShelf_Desc":
                    item = item.OrderByDescending(d => d.OffShelf);
                    break;
                default://預設用destId升冪排序
                    item = item.OrderBy(d => d.DestId);
                    break;
            }
            return item;
        }
    }
}
