import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';
import { FormControl } from '@angular/forms';
import { debounceTime, distinctUntilChanged } from 'rxjs/operators';

import { Order } from '../../models';
import { OrderService } from '../../services/order.service';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-order-management',
  templateUrl: './order-management.component.html',
  styleUrls: ['./order-management.component.scss']
})
export class OrderManagementComponent implements OnInit {
  displayedColumns: string[] = ['productName', 'customerName', 'orderId', 'amount', 'status', 'actions'];
  dataSource = new MatTableDataSource<Order>();
  searchControl = new FormControl();
  
  // Statistics
  stats = {
    totalOrders: 2401200,
    newOrders: 1701900,
    completedOrders: 1405300,
    cancelledOrders: 99349
  };
  
  // Filters
  filters = {
    status: '',
    paymentStatus: '',
    shippingStatus: '',
    fromDate: null as Date | null,
    toDate: null as Date | null,
    search: ''
  };

  // Pagination
  pageSize = 10;
  currentPage = 0;
  totalOrders = 0;
  
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  constructor(
    private orderService: OrderService,
    private authService: AuthService,
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.loadOrders();
    this.setupSearch();
  }

  setupSearch(): void {
    this.searchControl.valueChanges
      .pipe(debounceTime(300), distinctUntilChanged())
      .subscribe(value => {
        this.filters.search = value;
        this.applyFilters();
      });
  }

  loadOrders(): void {
    this.orderService.getOrders()
      .subscribe({
        next: (orders: any[]) => {
          this.dataSource.data = orders;
          this.totalOrders = orders.length;
          this.updateStats();
        },
        error: (error: any) => {
          console.error('Error loading orders:', error);
        }
      });
  }

  updateStats(): void {
    // Update statistics based on loaded orders
    // This is a simplified version - in real app, you'd get these from a dedicated API
    this.stats = {
      totalOrders: this.totalOrders,
      newOrders: this.dataSource.data.filter(o => o.status === 'PENDING').length,
      completedOrders: this.dataSource.data.filter(o => o.status === 'DELIVERED').length,
      cancelledOrders: this.dataSource.data.filter(o => o.status === 'CANCELLED').length
    };
  }

  applyFilters(): void {
    this.currentPage = 0;
    this.loadOrders();
  }

  clearFilters(): void {
    this.filters = {
      status: '',
      paymentStatus: '',
      shippingStatus: '',
      fromDate: null,
      toDate: null,
      search: ''
    };
    this.searchControl.setValue('');
    this.applyFilters();
  }

  // Helper methods for template
  getOrderProductName(order: Order): string {
    return order.orderItems?.[0]?.productName || 'N/A';
  }

  getOrderProductCategory(order: Order): string {
    return order.orderItems?.[0]?.product?.category?.name || 'N/A';
  }

  getOrderProductImage(order: Order): string {
    const product = order.orderItems?.[0]?.product;
    if (product?.images && product.images.length > 0) {
      return product.images[0].imageUrl;
    }
    return 'assets/default-product.png';
  }

  getCustomerName(order: Order): string {
    return order.customer?.contactPerson || order.user?.firstName + ' ' + order.user?.lastName || 'N/A';
  }

  getCustomerType(order: Order): string {
    return order.customer?.customerType || 'Pro Customer';
  }

  getCustomerAvatar(order: Order): string {
    return 'assets/default-avatar.png';
  }

  public getPaymentMethod(order: Order): string {
    return order.paymentStatus || 'Unknown';
  }

  getStatusClass(status: string): string {
    switch (status?.toLowerCase()) {
      case 'pending': return 'status-pending';
      case 'confirmed': return 'status-confirmed';
      case 'processing': return 'status-processing';
      case 'shipped': return 'status-shipped';
      case 'delivered': return 'status-accepted';
      case 'cancelled': return 'status-rejected';
      case 'refunded': return 'status-rejected';
      default: return 'status-pending';
    }
  }

  // Action methods
  addOrder(): void {
    // Implementation for adding new order
    this.snackBar.open('Add order functionality to be implemented', 'Close', { duration: 3000 });
  }

  updateOrderStatus(order: Order): void {
    // Implementation for updating order status
    this.snackBar.open('Update order status functionality to be implemented', 'Close', { duration: 3000 });
  }

  printOrder(order: Order): void {
    // Implementation for printing order
    this.snackBar.open('Print order functionality to be implemented', 'Close', { duration: 3000 });
  }

  onPageChange(event: PageEvent): void {
    this.currentPage = event.pageIndex;
    this.pageSize = event.pageSize;
    this.loadOrders();
  }
}
