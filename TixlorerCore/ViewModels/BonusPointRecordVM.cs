using TixlorerCore.Models;

namespace TixlorerCore.ViewModels
{
    public class BonusPointRecordVM
    {
        public string MId { get; set; } 
        public string MName { get; set; } 
        public int BonusPoint { get; set; }
        public int OperateType { get; set; }
        public DateTime Date { get; set; }
        public string OrderId { get; set; }
        public string OperateTypeText { get; set; }  //讓點數使用取得紀錄在View能以中文顯示
    }
}
