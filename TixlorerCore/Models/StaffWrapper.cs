using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace TixlorerCore.Models
{
    public class StaffWrapper
    {
        internal Staff _staff;

        public StaffWrapper()
        {
            if (_staff == null)
            {
                _staff = new Staff();
            }
        }
        public Staff staff { get { return _staff; } set { _staff = value; } }
        [Required(ErrorMessage = "必填欄位")]
        public string SId { get { return _staff.SId; } set { _staff.SId = value; } }
        [DisplayName("員工帳號")]
        [Required(ErrorMessage = "帳號必須填寫")]
        [StringLength(16,ErrorMessage = "帳號最多填寫16位半形英數字")]
        public string Account { get { return _staff.Account; } set { _staff.Account = value; } }
        [DisplayName("員工密碼")]
        [Required(ErrorMessage = "密碼必須填寫")]
        [StringLength(16, ErrorMessage = "密碼最多填寫16位半形英數字")]
        public string Password { get { return _staff.Password; } set { _staff.Password = value; } }

        [DisplayName("姓名")]
        [Required(ErrorMessage = "員工姓名必須填寫")]
        public string Name { get { return _staff.Name; } set { _staff.Name = value; } }

        [DisplayName("性別")]
        [Required(ErrorMessage = "性別必須選擇")]
        public int Sex { get { return _staff.Sex; } set { _staff.Sex = value; } }
        [DisplayName("身分證字號")]
        [Required(ErrorMessage = "身分證字號必須填寫")]
        public string IdNumber { get { return _staff.IdNumber; } set { _staff.IdNumber = value; } }
        [DisplayName("聯絡電話")]
        [Required(ErrorMessage = "聯絡電話必須填寫")]
        public string Phone { get { return _staff.Phone; } set { _staff.Phone = value; } }
        [DisplayName("電子信箱")]
        [Required(ErrorMessage = "電子信箱必須填寫")]
        [DataType(DataType.EmailAddress, ErrorMessage = "電子信箱格式錯誤")]
        public string Email { get { return _staff.Email; } set { _staff.Email = value; } }
        [DisplayName("生日")]
        [Required(ErrorMessage = "生日必須填寫")]
        public DateTime Birthday { get { return _staff.Birthday; } set { _staff.Birthday = value; } }
        [DisplayName("居住地址")]
        [Required(ErrorMessage = "居住地址必須填寫")]
        public string Address { get { return _staff.Address; } set { _staff.Address = value; } }
        [DisplayName("員工大頭照")]
        public string? Image { get { return _staff.Image; } set { _staff.Image = value; } }
        [DisplayName("所屬部門")]
        [Required(ErrorMessage = "所屬部門必須填寫")]
        public int Department { get { return _staff.Department; } set { _staff.Department = value; } }
        [DisplayName("職稱")]
        [Required(ErrorMessage = "職稱必須填寫")]
        public int JobPosition { get { return _staff.JobPosition; } set { _staff.JobPosition = value; } }
        [DisplayName("直屬主管")]
        public string? LineManager { get { return _staff.LineManager; } set { _staff.LineManager = value; } }
        [DisplayName("薪資")]
        [Required(ErrorMessage = "薪資必須填寫")]
        public decimal Salary { get { return _staff.Salary; } set { _staff.Salary = value; } }
        [DisplayName("到職日期")]
        [Required(ErrorMessage = "到職日期必須填寫")]
        public DateTime DateOfEmployment { get { return _staff.DateOfEmployment; } set { _staff.DateOfEmployment = value; } }
        [DisplayName("離職日期")]
        public DateTime? TerminationDate { get { return _staff.TerminationDate; } set { _staff.TerminationDate = value; } }
        [DisplayName("在職狀態")]
        [Required(ErrorMessage = "在職狀態必須填寫")]
        public int State { get { return _staff.State; } set { _staff.State = value; } }
        public IFormFile photo { get; set; }
    }
}
