using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace MVCEmpresa.Models;

public partial class Sueldo
{
    [Key] // Simula una clave primaria para EF
    public int FakeId { get; set; }
    public decimal? SueldoEmpleado { get; set; }

    public string? FormaDePago { get; set; }

    public string? Empleado { get; set; }

    public virtual Empleado? EmpleadoNavigation { get; set; }
}
