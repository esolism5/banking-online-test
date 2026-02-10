import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

/**
 * =====================================================
 * COMPONENTE PRINCIPAL DE LA APLICACIÓN
 * Fundación Genesis Empresarial
 * =====================================================
 * 
 * Este es el componente raíz que contiene toda la aplicación.
 * Aquí se renderiza el router-outlet donde se cargan los demás componentes.
 */
@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  template: `
    <div class="app-container">
      <router-outlet></router-outlet>
    </div>
  `,
  styles: [`
    .app-container {
      width: 100%;
      min-height: 100vh;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
  `]
})
export class AppComponent {
  title = 'Genesis Bancario';
}
