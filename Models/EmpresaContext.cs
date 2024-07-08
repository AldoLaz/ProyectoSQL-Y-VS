using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace MVCEmpresa.Models;

public partial class EmpresaContext : DbContext
{
    public EmpresaContext()
    {
    }

    public EmpresaContext(DbContextOptions<EmpresaContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Departamento> Departamentos { get; set; }

    public virtual DbSet<Empleado> Empleados { get; set; }

    public virtual DbSet<Sueldo> Sueldos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=EMPRESA;Integrated Security=True; TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Departamento>(entity =>
        {
            entity.HasKey(e => e.ClaveDepartamento).HasName("PK__Departam__2A9108F8A0793267");

            entity.Property(e => e.ClaveDepartamento).ValueGeneratedNever();
            entity.Property(e => e.Descripcion)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Empleado>(entity =>
        {
            entity.HasKey(e => e.ClaveDeEmpleado).HasName("PK__Empleado__78697EE87E5359E3");

            entity.Property(e => e.ClaveDeEmpleado)
                .HasMaxLength(8)
                .IsUnicode(false);
            entity.Property(e => e.NombreEmpleado)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.DepartamentoNavigation).WithMany(p => p.Empleados)
                .HasForeignKey(d => d.Departamento)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Empleados__Depar__398D8EEE");
        });

        modelBuilder.Entity<Sueldo>(entity =>
        {
            entity.HasKey(e => e.FakeId).HasName("PK__Sueldo__78697EE87E5359E3");

            entity.Property(e => e.Empleado)
                .HasMaxLength(8)
                .IsUnicode(false);
            entity.Property(e => e.FormaDePago)
                .HasMaxLength(15)
                .IsUnicode(false);
            entity.Property(e => e.SueldoEmpleado).HasColumnType("money");

            entity.HasOne(d => d.EmpleadoNavigation).WithMany()
                .HasForeignKey(d => d.Empleado)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Sueldos__Emplead__3B75D760");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
