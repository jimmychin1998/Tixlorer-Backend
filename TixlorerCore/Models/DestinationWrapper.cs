using Microsoft.CodeAnalysis.CSharp.Syntax;

namespace TixlorerCore.Models
{
    public class DestinationWrapper
    {
        internal Destination _destination;

        public DestinationWrapper()
        {
            if (_destination == null)
                _destination = new Destination();
        }
        public Destination destination { get { return _destination; } set { _destination = value; } }

        public string DestId { get { return _destination.DestId; } set { _destination.DestId = value; } }

        public string Name { get { return _destination.Name; } set { _destination.Name = value; } }

        public int Type { get { return _destination.Type; } set { _destination.Type = value; } }

        public string County { get { return _destination.County; } set { _destination.County = value; } }

        public string Phone { get { return _destination.Phone; } set { _destination.Phone = value; } }

        public string Address { get { return _destination.Address; } set { _destination.Address = value; } }

        public decimal Longitude { get { return _destination.Longitude; } set { _destination.Longitude = value; } }

        public decimal Latitude { get { return _destination.Latitude; } set { _destination.Latitude = value; } }

        public string? Desc { get { return _destination.Desc; } set { _destination.Desc = value; } }

        public string? Image { get { return _destination.Image; } set { _destination.Image = value; } }

        public DateTime? OnShelf { get { return _destination.OnShelf; } set { _destination.OnShelf = value; } }

        public DateTime? OffShelf { get { return _destination.OffShelf; } set { _destination.OffShelf = value; } }

        public string? Url { get { return _destination.Url; } set { _destination.Url = value; } }

        public virtual ICollection<DestComment> DestComments { get { return _destination.DestComments; } set { _destination.DestComments = value; } }

        public virtual ICollection<Ticket> Tickets { get { return _destination.Tickets; } set { _destination.Tickets = value; } }

        public IFormFile photo { get; set; }
    }
}
