import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';
import { Order } from '../models';

@Injectable({
  providedIn: 'root'
})
export class OrderService {
  private apiUrl = `${environment.apiUrl}/orders`;
  private cartApiUrl = `${environment.apiUrl}/cart`;

  constructor(private http: HttpClient) { }

  getOrders(): Observable<Order[]> {
    return this.http.get<Order[]>(this.apiUrl);
  }

  getOrderById(id: number): Observable<Order> {
    return this.http.get<Order>(`${this.apiUrl}/${id}`);
  }

  placeOrder(orderData: any): Observable<Order> {
    return this.http.post<Order>(`${this.cartApiUrl}/checkout`, orderData);
  }

  // For users to get their own orders
  getUserOrders(page: number = 0, size: number = 10): Observable<any> {
    return this.http.get<any>(`${environment.apiUrl}/user/orders?page=${page}&size=${size}`);
  }

  // For users to get a specific order
  getUserOrder(id: number): Observable<Order> {
    return this.http.get<Order>(`${environment.apiUrl}/user/orders/${id}`);
  }

  // Cancel order (only if pending)
  cancelOrder(id: number): Observable<Order> {
    return this.http.put<Order>(`${environment.apiUrl}/user/orders/${id}/cancel`, {});
  }

  // Admin/Seller methods
  getAllOrders(params: any = {}): Observable<any> {
    const queryParams = new URLSearchParams(params).toString();
    return this.http.get<any>(`${environment.apiUrl}/admin/orders?${queryParams}`);
  }

  updateOrderStatus(id: number, status: string): Observable<Order> {
    return this.http.put<Order>(`${environment.apiUrl}/admin/orders/${id}/status?status=${status}`, {});
  }

  updatePaymentStatus(id: number, paymentStatus: string): Observable<Order> {
    return this.http.put<Order>(`${environment.apiUrl}/admin/orders/${id}/payment-status?paymentStatus=${paymentStatus}`, {});
  }

  updateShippingStatus(id: number, shippingStatus: string, trackingNumber?: string): Observable<Order> {
    const params = trackingNumber ? `?shippingStatus=${shippingStatus}&trackingNumber=${trackingNumber}` : `?shippingStatus=${shippingStatus}`;
    return this.http.put<Order>(`${environment.apiUrl}/admin/orders/${id}/shipping-status${params}`, {});
  }

  getOrderStatistics(startDate?: string, endDate?: string): Observable<any> {
    const params = new URLSearchParams();
    if (startDate) params.append('startDate', startDate);
    if (endDate) params.append('endDate', endDate);
    
    return this.http.get<any>(`${environment.apiUrl}/admin/orders/statistics?${params.toString()}`);
  }

  searchOrders(query: string, page: number = 0, size: number = 10): Observable<any> {
    return this.http.get<any>(`${environment.apiUrl}/admin/orders/search?query=${query}&page=${page}&size=${size}`);
  }

  addOrderNotes(id: number, notes: string): Observable<Order> {
    return this.http.put<Order>(`${environment.apiUrl}/admin/orders/${id}/notes`, { notes });
  }
}