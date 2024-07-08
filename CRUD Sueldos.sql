/*CRUD SUELDOS*/

/*CREAR SUELDOS*/
Create procedure Crear_Sueldo
@SueldoEmpleado money, @FormaDePago varchar(15), @Empleado varchar(8) 
as 
Insert into Sueldos values(@SueldoEmpleado, @FormaDePago, @Empleado )

/*MODIFICAR EMPLEADO*/
Create procedure Modificar_Sueldo
@Empleado varchar(8), @SueldoEmpleado money, @FormaDePago varchar(15) as
Update Sueldos
set SueldoEmpleado = @SueldoEmpleado, FormaDePago = @FormaDePago
where Empleado = @Empleado

/*ELIMINAR REGISTRO DE SUELDOS*/
Create procedure Eliminar_Sueldo
@Empleado varchar(8) as
Delete from Sueldos
where Empleado = @Empleado

/*VER TODOS LOS EMPLEADOS*/
Create procedure Ver_Sueldos
as
Select * from Sueldos