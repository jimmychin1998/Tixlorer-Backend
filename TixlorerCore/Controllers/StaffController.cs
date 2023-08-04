using Microsoft.AspNetCore.Mvc;
using TixlorerCore.Models;
using TixlorerCore.ViewModels;
using System.Text.Json;
using System.Collections;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.Data;

namespace TixlorerCore.Controllers
{
    public class StaffController : Controller
    {
        private IWebHostEnvironment _enviro = null;
        public StaffController(IWebHostEnvironment p)
        {
            _enviro = p;
        }
        public IActionResult Login()
        {//員工登入頁面 - 預設為首頁
            //正式情況下，沒有進行登入無法進行系統操作
            return View();
        }
        [HttpPost]
        public IActionResult Login(LoginViewModel vm)
        {
            Staff staff = (new TixplorerContext()).Staff.FirstOrDefault(t => t.Account.Equals(vm.txtStaffAccount) && t.Password.Equals(vm.txtStaffPassword));
            if (staff != null && ModelState.IsValid)
            {//輸入的帳號密碼正確時紀錄Session驗證資訊，要有驗證資訊才有辦法進入其他頁面
                string json = JsonSerializer.Serialize(staff);

                HttpContext.Session.SetString(CDictionay.SK_LOGINED_STAFF, json);
                return RedirectToAction("PersonDataModify");
            }
            //設置錯誤訊息，以下會尋找View內的ValidationMessage其Name值為"LoginError"的標籤位置，並於驗證錯誤時顯示所設定的錯誤訊息
            ModelState.AddModelError("LoginError", "帳號或密碼錯誤，請重新輸入");
            //MVC的特性，一旦資料ModelBinding過，則重返該畫面的時候會自動繫結
            return View();
        }

        public ActionResult PersonDataModify()
        {//員工個人資料修改頁面 => 無參考模板
            if (HttpContext.Session.Keys.Contains(CDictionay.SK_LOGINED_STAFF))
            {
                Staff json = JsonSerializer.Deserialize<Staff>(HttpContext.Session.GetString(CDictionay.SK_LOGINED_STAFF));

                //驗證Session取得的ID是否與資料庫資料相同(保險起見)
                TixplorerContext db = new TixplorerContext();
                var datas = from s in db.Staff where s.SId == json.SId select s;

                if (datas != null)
                    return View(datas);
                return RedirectToAction("Login");
            }
            //如果沒有登入Session，則不允許進入個人介面
            return RedirectToAction("Login");
        }
        [HttpPost]
        public ActionResult PersonDataModify(StaffWrapper item)
        {//員工個人資料修改頁面 => 無參考模板
            TixplorerContext db = new TixplorerContext();
            Staff staff = db.Staff.FirstOrDefault(s => s.SId == item.SId);
            if (staff != null)
            {
                //以下僅針對可修改資料做存取
                staff.IdNumber = item.IdNumber;
                staff.Phone = item.Phone;
                staff.Email = item.Email;
                staff.Address = item.Address;
                //如果照片為空值或預設無圖片(NoImage.png)，則給予值"NoImage.png"
                //照片修改的資料存取
                if (item.photo != null)
                {//如果上傳照片不為空值時，進行照片路徑的更新作業，並建立新的照片檔案於images內
                    string photoName = Guid.NewGuid().ToString() + ".jpg";
                    item.photo.CopyTo(new FileStream(_enviro.WebRootPath + "/images/StaffImages/" + photoName, FileMode.Create));
                    staff.Image = photoName;
                }
                db.SaveChanges();
            }

            //儲存完成，
            return RedirectToAction("PersonDataModify");
        }

        public ActionResult List(StaffKeywordVM vm)
        {//員工資料管理頁面 => 參考模板「List」
            if (HttpContext.Session.Keys.Contains(CDictionay.SK_LOGINED_STAFF))
            {
                string keyword = vm.txtKeyword;
                TixplorerContext db = new TixplorerContext();
                IEnumerable<Staff> datas = null;
                if (vm.txtConditionType == "99" || string.IsNullOrEmpty(vm.txtConditionType))
                {
                    //當沒有查詢關鍵字時，取得所有員工資料
                    datas = from s in db.Staff select s;
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
            //如果沒有登入Session，則不允許進入個人介面
            return RedirectToAction("Login");
        }

        public ActionResult Create()
        {//新建員工介面
            //設置員工在職狀態下拉選單值
            ListJobStateCategorySet();

            return View();
        }
        [HttpPost]
        public ActionResult Create(StaffWrapper item)
        {
            TixplorerContext db = new TixplorerContext();
            //回傳物件item預設值設定
            item = CreateDefault(item);

            db.Staff.Add(item._staff);
            db.SaveChanges();
            return RedirectToAction("List");
        }

        public ActionResult Edit(string? id)
        {//員工資料編輯頁面 兼 員工詳細資料查看頁面
            if (id == null)
            {
                //編輯資料時若無資料可編輯，則重新回到員工清單(List)
                return RedirectToAction("List");
            }
            //如果編輯資料時，有資料可以編輯才可進入介面
            TixplorerContext db = new TixplorerContext();
            Staff Sqldatas = db.Staff.FirstOrDefault(s => s.SId == id);
            StaffWrapper datas = new StaffWrapper();
            datas._staff = Sqldatas;

            //設置員工在職狀態下拉選單值
            ListJobStateCategorySet();

            return View(datas);

        }
        [HttpPost]
        public ActionResult Edit(StaffWrapper item)
        {
            TixplorerContext db = new TixplorerContext();
            Staff staff = db.Staff.FirstOrDefault(s => s.SId == item.SId);
            if (staff != null)
            {
                //如果當前資料庫內有修改的員工編號資料，則開始進行資料修改的存取
                staff.Account = item.Account;
                staff.Password = item.Password;
                staff.Name = item.Name;
                staff.Sex = item.Sex;
                staff.IdNumber = item.IdNumber;
                staff.Phone = EditDefault(item).Phone;
                staff.Email = item.Email;
                staff.Birthday = item.Birthday;
                staff.Address = item.Address;
                staff.Department = item.Department;
                staff.JobPosition = item.JobPosition;
                staff.LineManager = item.LineManager;
                staff.Salary = item.Salary;
                staff.DateOfEmployment = item.DateOfEmployment;
                staff.TerminationDate = item.TerminationDate;
                staff.State = item.State;
                //照片修改的資料存取
                if (item.photo != null)
                {//如果上傳照片不為空值時，進行照片路徑的更新作業，並建立新的照片檔案於images內
                    string photoName = Guid.NewGuid().ToString() + ".jpg";
                    item.photo.CopyTo(new FileStream(_enviro.WebRootPath + "/images/StaffImages/" + photoName, FileMode.Create));
                    staff.Image = photoName;
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
                Staff staff = db.Staff.FirstOrDefault(s => s.SId == id);
                if (staff != null)
                {
                    db.Staff.Remove(staff);
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

        private IEnumerable<Staff>? ConditionSearch(int ConditionType, string keyword)
        {//根據條件查詢的選擇產生不同的Linq查詢語法
            IEnumerable<Staff> results = null;
            TixplorerContext db = new TixplorerContext();
            switch (ConditionType)
            {
                case 0://查詢條件為「員工編號」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Staff;
                    else
                        results = db.Staff.Where(s => s.SId.Contains(keyword));
                    break;
                case 1://查詢條件為「員工姓名」時
                    if (string.IsNullOrEmpty(keyword))
                        results = db.Staff;
                    else
                        results = db.Staff.Where(s => s.Name.Contains(keyword));
                    break;
                default:
                    break;
            }
            return results;
        }

        public ActionResult ListJobStateCategorySet()
        {//建置於List畫面中，條件搜尋下拉清單的內容
            List<SelectListItem> listitem = new List<SelectListItem>();
            listitem.Add(new SelectListItem { Text = "在職", Value = "0" });
            listitem.Add(new SelectListItem { Text = "離職", Value = "1" });
            listitem.Add(new SelectListItem { Text = "留職停薪", Value = "2" });
            listitem.Add(new SelectListItem { Text = "未到職", Value = "3" });

            ViewBag.JobStateType = listitem;
            return View();
        }

        public StaffWrapper CreateDefault(StaffWrapper item)
        {//此方法用於建立新建員工時部分預設值，如「在職狀態」
            //判斷若員工的到職日期比現在時間晚，則員工狀態設定為「未到職」，否則為「在職」
            if (item.DateOfEmployment > DateTime.Now)
                item.State = 3;//未到職
            else
                item.State = 0;//在職

            //照片修改的資料存取
            if (item.photo != null)
            {//如果上傳照片不為空值時，進行照片路徑的更新作業，並建立新的照片檔案於images內
                string photoName = Guid.NewGuid().ToString() + ".jpg";
                item.photo.CopyTo(new FileStream(_enviro.WebRootPath + "/images/StaffImages/" + photoName, FileMode.Create));
                item.Image = photoName;
            }
            else
            {
                //上傳照片若為空值時，預設其值為"NoImage.png"
                item.Image = "NoImage.png";
            }

            return item;
        }

        public StaffWrapper EditDefault(StaffWrapper item)
        {//此方法用於編輯員工資料時格式化部分資料，如「聯絡電話」

            return item;
        }

        public IEnumerable<Staff> sortByItem(IEnumerable<Staff> item, string sortBy)
        {//清單排序功能，根據所點選的標題來做升冪、降冪的排序
            ViewBag.sortById = string.IsNullOrEmpty(sortBy) ? "Id_Desc" : "";
            ViewBag.sortByName = sortBy == "Name" ? "Name_Desc" : "Name";
            ViewBag.sortByDepartment = sortBy == "Department" ? "Department_Desc" : "Department";
            ViewBag.sortByJobPosition = sortBy == "JobPosition" ? "JobPosition_Desc" : "JobPosition";
            ViewBag.sortByDOE = sortBy == "DOE" ? "DOE_Desc" : "DOE";
            ViewBag.sortByState = sortBy == "State" ? "State_Desc" : "State";
            switch (sortBy)
            {
                case "Id_Desc":
                    item = item.OrderByDescending(s => s.SId);
                    break;
                case "Name":
                    item = item.OrderBy(s => s.Name);
                    break;
                case "Name_Desc":
                    item = item.OrderByDescending(s => s.Name);
                    break;
                case "Department":
                    item = item.OrderBy(s => s.Department);
                    break;
                case "Department_Desc":
                    item = item.OrderByDescending(s => s.Department);
                    break;
                case "JobPosition":
                    item = item.OrderBy(s => s.JobPosition);
                    break;
                case "JobPosition_Desc":
                    item = item.OrderByDescending(s => s.JobPosition);
                    break;
                case "DOE":
                    item = item.OrderBy(s => s.DateOfEmployment);
                    break;
                case "DOE_Desc":
                    item = item.OrderByDescending(s => s.DateOfEmployment);
                    break;
                case "State":
                    item = item.OrderBy(s => s.State);
                    break;
                case "State_Desc":
                    item = item.OrderByDescending(s => s.State);
                    break;
                default://預設用SId升冪排序
                    item = item.OrderBy(s => s.SId);
                    break;
            }
            return item;
        }
    }
}
