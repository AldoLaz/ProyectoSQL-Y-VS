using System;
using System.Collections.Generic;

namespace MVCEmpresa.Models;

public partial class Empleado
{
    public string ClaveDeEmpleado { get; set; } = null!;

    public string NombreEmpleado { get; set; } = null!;

    public DateOnly FechaIngreso { get; set; }

    public DateOnly FechaNacimiento { get; set; }

    public int? Departamento { get; set; }

    public virtual Departamento? DepartamentoNavigation { get; set; }
}
