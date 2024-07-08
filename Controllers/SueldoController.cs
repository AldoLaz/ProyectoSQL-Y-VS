using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MVCEmpresa.Models;

namespace MVCEmpresa.Controllers
{
    public class SueldoController : Controller
    {
        private readonly EmpresaContext _context;

        public SueldoController(EmpresaContext context)
        {
            _context = context;
        }

        // GET: Sueldo
        public async Task<IActionResult> Index()
        {
            var empresaContext = _context.Sueldos.Include(s => s.EmpleadoNavigation);
            return View(await empresaContext.ToListAsync());
        }

        // GET: Sueldo/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sueldo = await _context.Sueldos
                .Include(s => s.EmpleadoNavigation)
                .FirstOrDefaultAsync(m => m.FakeId == id);
            if (sueldo == null)
            {
                return NotFound();
            }

            return View(sueldo);
        }

        // GET: Sueldo/Create
        public IActionResult Create()
        {
            ViewData["Empleado"] = new SelectList(_context.Empleados, "ClaveDeEmpleado", "ClaveDeEmpleado");
            return View();
        }

        // POST: Sueldo/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("FakeId,SueldoEmpleado,FormaDePago,Empleado")] Sueldo sueldo)
        {
            if (ModelState.IsValid)
            {
                _context.Add(sueldo);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["Empleado"] = new SelectList(_context.Empleados, "ClaveDeEmpleado", "ClaveDeEmpleado", sueldo.Empleado);
            return View(sueldo);
        }

        // GET: Sueldo/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sueldo = await _context.Sueldos.FindAsync(id);
            if (sueldo == null)
            {
                return NotFound();
            }
            ViewData["Empleado"] = new SelectList(_context.Empleados, "ClaveDeEmpleado", "ClaveDeEmpleado", sueldo.Empleado);
            return View(sueldo);
        }

        // POST: Sueldo/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("FakeId,SueldoEmpleado,FormaDePago,Empleado")] Sueldo sueldo)
        {
            if (id != sueldo.FakeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(sueldo);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SueldoExists(sueldo.FakeId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["Empleado"] = new SelectList(_context.Empleados, "ClaveDeEmpleado", "ClaveDeEmpleado", sueldo.Empleado);
            return View(sueldo);
        }

        // GET: Sueldo/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sueldo = await _context.Sueldos
                .Include(s => s.EmpleadoNavigation)
                .FirstOrDefaultAsync(m => m.FakeId == id);
            if (sueldo == null)
            {
                return NotFound();
            }

            return View(sueldo);
        }

        // POST: Sueldo/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var sueldo = await _context.Sueldos.FindAsync(id);
            if (sueldo != null)
            {
                _context.Sueldos.Remove(sueldo);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool SueldoExists(int id)
        {
            return _context.Sueldos.Any(e => e.FakeId == id);
        }
    }
}
