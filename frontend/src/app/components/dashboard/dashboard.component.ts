import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  Math = Math;   // <-- agregar esta línea

  usuario: any = {
    nombre_completo: 'María Elena García López',
    email: 'maria.garcia@gmail.com'
  };

  saldoTotal: number = 0;
  cuentas: any[] = [];
  transaccionesRecientes: any[] = [];
  prestamos: any[] = [];
  loading: boolean = true;

  constructor(private router: Router) {}

  ngOnInit(): void {
    this.cargarDatos();
  }

  cargarDatos(): void {
    setTimeout(() => {
      this.saldoTotal = 23950.50;

      this.cuentas = [
        {
          id_cuenta: 1,
          numero_cuenta: '1001234567890001',
          tipo_cuenta_nombre: 'Cuenta de Ahorro',
          saldo: 15750.50,
          moneda: 'GTQ'
        },
        {
          id_cuenta: 2,
          numero_cuenta: '1001234567890002',
          tipo_cuenta_nombre: 'Cuenta Monetaria',
          saldo: 8200.00,
          moneda: 'GTQ'
        }
      ];

      this.transaccionesRecientes = [
        {
          id_transaccion: 1,
          tipo_nombre: 'Transferencia',
          monto: 1500.00,
          descripcion: 'Pago de servicios',
          fecha_transaccion: new Date('2025-02-08'),
          estado: 'completada'
        },
        {
          id_transaccion: 2,
          tipo_nombre: 'Depósito',
          monto: 5000.00,
          descripcion: 'Depósito en efectivo',
          fecha_transaccion: new Date('2025-02-07'),
          estado: 'completada'
        },
        {
          id_transaccion: 3,
          tipo_nombre: 'Pago de Servicios',
          monto: -450.00,
          descripcion: 'EEGSA - Energía eléctrica',
          fecha_transaccion: new Date('2025-02-06'),
          estado: 'completada'
        }
      ];

      this.prestamos = [
        {
          id_prestamo: 1,
          monto_aprobado: 50000.00,
          saldo_pendiente: 42500.00,
          cuota_mensual: 2365.72,
          estado: 'en_pago'
        }
      ];

      this.loading = false;
    }, 1000);
  }

  verTransacciones(): void {
    this.router.navigate(['/transacciones']);
  }

  verCuentas(): void {
    this.router.navigate(['/cuentas']);
  }

  nuevaTransferencia(): void {
    this.router.navigate(['/transacciones/nueva']);
  }

  formatearMoneda(monto: number): string {
    return new Intl.NumberFormat('es-GT', {
      style: 'currency',
      currency: 'GTQ'
    }).format(monto);
  }
}
