
Create Database EMPRESA 
use EMPRESA
Create table Empleados(ClaveDeEmpleado varchar(8) primary key not null ,
NombreEmpleado varchar(50) not null,
FechaIngreso date not null,
FechaNacimiento date not null,
Departamento int, foreign key (Departamento) References Departamentos(ClaveDepartamento) On Delete cascade
)

Create table Sueldos(FakeId int Identity(1,1),SueldoEmpleado money,
FormaDePago varchar(15),
Empleado varchar(8), foreign key(Empleado) references Empleados(ClaveDeEmpleado) On Delete cascade
)

Create table Departamentos(ClaveDepartamento int primary key not null,
Descripcion varchar(50) not null
)

/*Insertando datos en la base de datos*/

insert into Departamentos values(1,'Gerente de Desarrollo de Software')
insert into Departamentos values(2,'Desarrolladores de Software (Frontend y Backend)')
insert into Departamentos values(3, 'Ingenieros de QA (Quality Assurance)' )
insert into Departamentos values(4, 'Analistas de Negocios')
insert into Departamentos values(5, 'Scrum Masters / Coordinadores de Proyectos')
insert into Departamentos values(6, 'Departamento sin empleados')

insert into Empleados values('A5F6S4TT','Juan Carlos Rosales Hernandez', '2022/07/05', '1999/07/22',2)
insert into Empleados values('BC2H9IH5','Guillermo Lopez Hernandez', '2018/05/22', '2000/02/08',2)
insert into Empleados values('A5F6FF2T','Ernesto Lopez Lopez', '2020/01/01', '2001/02/06',1)
insert into Empleados values('A32Y9IH5','Carlos Fabian Gonzales Monroy', '2020/10/01', '1997/09/08',1)
insert into Empleados values('V4ILFF2T','Esmeralda Aguilar Lopez', '2020/01/20', '2001/09/30',3)
insert into Empleados values('A32YSS25','Arlette Monroy Ruiz', '2023/07/15', '1996/03/12',3)
insert into Empleados values('V4ILGH8T','Emanuel Hernandez Hernandez', '2019/10/20', '2002/03/19',4)
insert into Empleados values('TT7UI83D','America Sabrina Montes	Lara', '2024/12/24', '1995/12/24',4)
insert into Empleados values('UU89YY5T','Frida Esperanza Gomez Perez', '2017/03/03', '2002/03/18',5)
insert into Empleados values('AS56GHJ2','Luis Enrique Guillen Prado', '2019/11/22', '1994/11/08',5)
insert into Empleados values('AAAAAAAA','Empleado con mas de 30 años', '2019/11/22', '1990/11/08',5)

insert into Sueldos values(15000.00,'Transferencia','A5F6S4TT')
insert into Sueldos values(15000.00,'Transferencia','BC2H9IH5')
insert into Sueldos values(16500.00,'Transferencia','A5F6FF2T')
insert into Sueldos values(16500.00,'Efectivo','A32Y9IH5')
insert into Sueldos values(13800.00,'Transferencia','V4ILFF2T')
insert into Sueldos values(13800.00,'Efectivo','A32YSS25')
insert into Sueldos values(11900.00,'Transferencia','V4ILGH8T')
insert into Sueldos values(11900.00,'Efectivo','TT7UI83D')
insert into Sueldos values(18900.00,'Transferencia','UU89YY5T')
insert into Sueldos values(18900.00,'Efectivo','AS56GHJ2')
insert into Sueldos values(6500.00,'Efectivo','AAAAAAAA')

/*CONSULTAS*/

/*1.- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno
junto con su sueldo de cada empleado y su forma de pago*/

Select Empleados.NombreEmpleado as 'Nombre del Empleado',
Departamentos.Descripcion as 'Departamento', 
Sueldos.SueldoEmpleado as 'Sueldo Mensual', 
Sueldos.FormaDePago as 'Forma de pago' from 
Empleados,Departamentos,Sueldos Where
Empleados.ClaveDeEmpleado = Sueldos.Empleado and Departamentos.ClaveDepartamento = Empleados.Departamento

/*2.- Devuelve un listado con la clave y el nombre del departamento, solamente de aquellos
departamentos que tienen empleados.*/

Select Distinct ClaveDepartamento, Descripcion from Departamentos
inner join Empleados on Departamentos.ClaveDepartamento = Empleados.Departamento

/*3.- Devuelve un listado con el total de sueldos de cada departamento separado por forma de pago*/

Select Departamentos.Descripcion as 'Departamento',
    Sueldos.FormaDePago as 'Forma de Pago',
    SUM(Sueldos.SueldoEmpleado) as 'Total Sueldo'
from Empleados 
 inner join Departamentos 
on Departamentos.ClaveDepartamento = Empleados.Departamento
 inner join Sueldos 
on Sueldos.Empleado = Empleados.ClaveDeEmpleado
group by  Departamentos.Descripcion, Sueldos.FormaDePago
order by  Departamentos.Descripcion, Sueldos.FormaDePago
   
/*4.- Devuelve un listado de los empleados mayores de 30 años que tengan un sueldo mayor a 6 mil
ordenado de mayor a menor*/

select Empleados.NombreEmpleado,
DATEDIFF(YEAR,FechaNacimiento,GETDATE()) as 'Edad',
Sueldos.SueldoEmpleado as 'Sueldo' from
Empleados inner join Sueldos
On Empleados.ClaveDeEmpleado = Sueldos.Empleado
where  SueldoEmpleado>6000.00 and DATEDIFF(YEAR,FechaNacimiento,GETDATE())>30
order by Edad desc

/*5.- Devuelve un listado con los empleados que ingresaron en año actual*/
select NombreEmpleado from Empleados 
where YEAR(FechaIngreso)= YEAR(GETDATE())

/*6.- Devuelve un listado con la edad y su fecha de nacimiento de cada empleado ordenado de mayor a
menor*/
select NombreEmpleado as 'Nombre',
DATEDIFF(YEAR,FechaNacimiento,GETDATE()) as 'Edad',
FechaNacimiento as 'Fecha de nacimiento'
from Empleados
order by Edad Desc

/*7.- Elaborar un procedimiento almacenado que devuelva el numero de empleado, nombre, fecha de
ingreso y sueldo filtrado por departamento, el procedimiento almacenado debe recibir la clave del
departamento a consultar*/

Create procedure ListaPorDepartamento
@ClaveDepartamento int AS 
select Empleados.ClaveDeEmpleado, Empleados.NombreEmpleado, Sueldos.SueldoEmpleado
from  Empleados inner join Departamentos 
on Empleados.Departamento = Departamentos.ClaveDepartamento 
inner join Sueldos 
on Empleados.ClaveDeEmpleado = Sueldos.Empleado
where Departamentos.ClaveDepartamento = @ClaveDepartamento

exec ListaPorDepartamento 1

