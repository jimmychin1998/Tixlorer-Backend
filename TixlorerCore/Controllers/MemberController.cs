using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using TixlorerCore.Models;
using TixlorerCore.ViewModels;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;

namespace TixlorerCore.Controllers
{
    public class MemberController : Controller
    {
        public IActionResult List(MemberKeywordVM vm)
        {
            string keyword = vm.txtKeyword;
            TixplorerContext db = new TixplorerContext();
            IEnumerable<Member> datas = null;
            if (vm.txtConditionType == "99" || string.IsNullOrEmpty(vm.txtConditionType))
            {
                //當沒有設定查詢條件時，取得所有會員資料
                datas = db.Members;
            }
            else
            {
                //當有查詢關鍵字時，根據查詢條件和關鍵字查詢指定資料
                datas = ConditionSearch(Convert.ToInt32(vm.txtConditionType), vm.txtKeyword);
            }
            //設置條件查詢下拉選單使用的內容
            ListSearchCategorySet();

            //根據當前選擇欄位進行欄位排序
            datas = sortByItem(datas,vm.sortBy);

            return View(datas);
        }
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(Member item)
        {
            TixplorerContext db = new TixplorerContext();
            item = CreateDefault(item);
            db.Members.Add(item);
            db.SaveChanges();
            return RedirectToAction("List");
        }

        public ActionResult Edit(string? id)
        {
            if (id == null)
            {
                //編輯資料時若無資料可編輯，則重新回到會員清單(List)
                return RedirectToAction("List");
            }
            TixplorerContext db = new TixplorerContext();
            var datas = db.Members.FirstOrDefault(d => d.MId == id);

            return View(datas);
        }
        [HttpPost]
        public ActionResult Edit(Member item)
        {
            TixplorerContext db = new TixplorerContext();
            Member member = db.Members.FirstOrDefault(d => d.MId == item.MId);
            if (member != null)
            {
                //如果當前資料庫內有修改的會員編號資料，則開始進行資料修改的存取
                db.SaveChanges();
            }
            return RedirectToAction("List");
        }

        public ActionResult Delete(string? id)
        {
            if (id != null)
            {
                TixplorerContext db = new TixplorerContext();
                Member member = db.Members.FirstOrDefault(s => s.MId == id);
                if (member != null)
                {
                    db.Members.Remove(member);
                    db.SaveChanges();
                }
            }
            return RedirectToAction("List");
        }

        public ActionResult ListSearchCategorySet()
        {//建置於List畫面中，條件搜尋下拉清單的內容
            List<SelectListItem> listitem = new List<SelectListItem>();
            listitem.Add(new SelectListItem { Text = "不選擇", Value = "99" });
            listitem.Add(new SelectListItem { Text = "員工編號", Value = "0" });
            listitem.Add(new SelectListItem { Text = "姓名", Value = "1" });

            ViewBag.ConditionType = listitem;
            return View();
        }

        private IEnumerable<Member>? ConditionSearch(int ConditionType, string keyword)
        {//根據條件查詢的選擇產生不同的Linq查詢語法
            IEnumerable<Member> results = null;
            TixplorerContext db = new TixplorerContext();
            switch (ConditionType)
            {
                case 0://查詢條件為「員工編號」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Members;
                    else
                        results = db.Members.Where(s => s.MId.Contains(keyword));
                    break;
                case 1://查詢條件為「員工姓名」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Members;
                    else
                        results = db.Members.Where(s => s.Name.Contains(keyword));
                    break;
                default:
                    break;
            }
            return results;
        }

        public Member CreateDefault(Member item)
        {//此方法用於建立新建會員時部分預設值，如「註冊日期」
            //設定註冊日期為當前年月日
            item.RegisterDate = DateTime.Now;

            //設定最後登入日期為null值
            item.LastLoginDate = null;

            //設置紅利點數預設值為0
            item.BonusPoint = 0;

            return item;
        }

        public IEnumerable<Member> sortByItem(IEnumerable<Member> item, string sortBy)
        {//清單排序功能，根據所點選的標題來做升冪、降冪的排序
            ViewBag.sortById = string.IsNullOrEmpty(sortBy) ? "Id_Desc" : "";
            ViewBag.sortByName = sortBy == "Name" ? "Name_Desc" : "Name";
            ViewBag.sortBySex = sortBy == "Sex" ? "Sex_Desc" : "Sex";
            ViewBag.sortByRegisterDate = sortBy == "RegisterDate" ? "RegisterDate_Desc" : "RegisterDate";
            switch (sortBy)
            {
                case "Id_Desc":
                    item = item.OrderByDescending(s => s.MId);
                    break;
                case "Name":
                    item = item.OrderBy(s => s.Name);
                    break;
                case "Name_Desc":
                    item = item.OrderByDescending(s => s.Name);
                    break;
                case "Sex":
                    item = item.OrderBy(s => s.Sex);
                    break;
                case "Sex_Desc":
                    item = item.OrderByDescending(s => s.Sex);
                    break;
                case "RegisterDate":
                    item = item.OrderBy(s => s.RegisterDate);
                    break;
                case "RegisterDate_Desc":
                    item = item.OrderByDescending(s => s.RegisterDate);
                    break;
                default://預設用MId升冪排序
                    item = item.OrderBy(s => s.MId);
                    break;
            }
            return item;
        }
    }
}
