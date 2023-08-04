using TixlorerCore.Models;

namespace TixlorerCore.TicketViewModels
{
    public class TicketViewModel
    {
        public string txtTicketKeyword { get; set; }
		public Ticket Tic { get; set; }
		public List<string> DestIds { get; set; }
        public List<string> SupplierIds { get; set; }

    }
}
