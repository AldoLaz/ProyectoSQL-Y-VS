
/*CRUD EMPLEADOS*/

/*CREAR EMPLEADO*/
Create procedure Crear_Empleado 
@ClaveDeEmpleado varchar(8), @NombreEmpleado varchar(50), @FechaIngreso date, @FechaNacimiento date, @Departamento int 
as 
Insert into Empleados values(@ClaveDeEmpleado, @NombreEmpleado, @FechaIngreso, @FechaNacimiento, @Departamento)

/*MODIFICAR EMPLEADO*/
Create procedure Modificar_Empleado
@ClaveDeEmpleado varchar(8), @NombreEmpleado varchar(50), @FechaIngreso date, @FechaNacimiento date, @Departamento int as
Update Empleados
set NombreEmpleado= @NombreEmpleado  , FechaIngreso = @FechaIngreso, FechaNacimiento = @FechaNacimiento, Departamento = @Departamento
where ClaveDeEmpleado= @ClaveDeEmpleado 

/*ELIMINAR REGISTRO DE EMPLEADO*/
Create procedure Eliminar_Empleado
@ClaveDeEmpleado varchar(8) as
Delete from Empleados
where ClaveDeEmpleado = @ClaveDeEmpleado

/*VER TODOS LOS EMPLEADOS*/
Create procedure Ver_Empleados 
as
begin
Select ClaveDeEmpleado, NombreEmpleado,FechaIngreso,FechaNacimiento,Departamento
from Empleados
end