import { bootstrapApplication } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { AppComponent } from './app/app.component';

const routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' as const },
  { 
    path: 'dashboard', 
    loadComponent: () => import('./app/components/dashboard/dashboard.component')
      .then(m => m.DashboardComponent)
  },
  { path: '**', redirectTo: '/dashboard' }
];

bootstrapApplication(AppComponent, {
  providers: [
    provideRouter(routes),
    provideHttpClient()
  ]
}).catch(err => console.error(err));
