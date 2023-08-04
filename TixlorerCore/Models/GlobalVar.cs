namespace TixlorerCore.Models
{
    public class GlobalVar
    {
        //存放全域變數或共用資訊使用

        //資料庫Entities(Context)更新使用指令：(下列註解指令複製並於Nuget主控台執行
        //Scaffold-DbContext "Data Source=.;Initial Catalog=Tixplorer;Integrated Security=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -force

        //如果需要使用ADO.NET，下方提供連線用字串
        //本機連線使用：不使用請註解掉程式碼行
        internal static string ConnectionStrBuilding = "Data Source=.;Initial Catalog=Tixplorer;Integrated Security=True";
        //遠端連線使用：不使用請註解掉程式碼行
        //public static string ConnectionStrBuilding = "Data Source=26.151.244.84;Initial Catalog=Tixplorer;User ID=VisualStudio;Password=03100808";
    }
}
