/*CRUD DEPARTAMENTOS*/

/*CREAR DEPARTAMENTO*/
Create procedure Crear_Departamento 
@ClaveDepartamento int, @Descripcion varchar(50) as 
Insert into Departamentos values(@ClaveDepartamento, @Descripcion)

/*MODIFICAR DEPARTAMENTO*/
Create procedure Modificar_Departamento
@ClaveDepartamento int, @Descripcion varchar(50) as 
Update Departamentos 
set ClaveDepartamento= @ClaveDepartamento, Descripcion =@Descripcion
where ClaveDepartamento =@ClaveDepartamento

/*ELIMINAR REGISTRO DEPARTAMENTO*/
Create procedure Eliminar_Departamento
@ClaveDepartamento int as
Delete from Departamentos
where ClaveDepartamento = @ClaveDepartamento 

/*VER TODOS LOS DEPARTAMENTOS*/
Create procedure Ver_Departamentos
as
Select * from Departamentos


