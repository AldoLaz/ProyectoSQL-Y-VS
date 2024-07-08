using System;
using System.Collections.Generic;

namespace MVCEmpresa.Models;

public partial class Departamento
{
    public int ClaveDepartamento { get; set; }

    public string Descripcion { get; set; } = null!;

    public virtual ICollection<Empleado> Empleados { get; set; } = new List<Empleado>();
}
