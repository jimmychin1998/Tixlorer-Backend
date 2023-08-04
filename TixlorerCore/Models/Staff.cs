using System;
using System.Collections.Generic;

namespace TixlorerCore.Models;

public partial class Staff
{
    public string SId { get; set; } = null!;

    public string Account { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Name { get; set; } = null!;

    public int Sex { get; set; }

    public string IdNumber { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public DateTime Birthday { get; set; }

    public string Address { get; set; } = null!;

    public string? Image { get; set; }

    public int Department { get; set; }

    public int JobPosition { get; set; }

    public string? LineManager { get; set; }

    public decimal Salary { get; set; }

    public DateTime DateOfEmployment { get; set; }

    public DateTime? TerminationDate { get; set; }

    public int State { get; set; }
}
