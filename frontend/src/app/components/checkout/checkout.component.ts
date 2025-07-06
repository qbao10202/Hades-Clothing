import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';
import { MatSnackBar } from '@angular/material/snack-bar';

import { Cart, Order, User } from '../../models';
import { CartService } from '../../services/cart.service';
import { OrderService } from '../../services/order.service';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-checkout',
  template: `
    <div class="checkout-page">
      <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
          <span routerLink="/cart">Cart</span>
          <mat-icon>chevron_right</mat-icon>
          <span>Shipping</span>
          <mat-icon>chevron_right</mat-icon>
          <span>Payment</span>
        </div>
        <div *ngIf="cart.items.length > 0; else emptyCart" class="checkout-content">
          <div class="checkout-form">
            <h2>Shipping Address</h2>
            <form [formGroup]="checkoutForm" (ngSubmit)="onSubmit()">
              <div class="form-row">
                <mat-form-field appearance="outline" class="half-width">
                  <mat-label>First Name*</mat-label>
                  <input matInput formControlName="firstName" required>
                </mat-form-field>
                <mat-form-field appearance="outline" class="half-width">
                  <mat-label>Last Name*</mat-label>
                  <input matInput formControlName="lastName" required>
                </mat-form-field>
              </div>
              <div class="form-row">
                <mat-form-field appearance="outline" class="full-width">
                  <mat-label>Email*</mat-label>
                  <input matInput formControlName="email" type="email" required>
                </mat-form-field>
              </div>
              <div class="form-row">
                <mat-form-field appearance="outline" class="full-width">
                  <mat-label>Phone number*</mat-label>
                  <mat-select formControlName="phoneCountry" class="country-select">
                    <mat-option value="IND">IND</mat-option>
                    <mat-option value="USA">USA</mat-option>
                    <mat-option value="VN">VN</mat-option>
                  </mat-select>
                  <input matInput formControlName="phone" type="tel" required>
                </mat-form-field>
              </div>
              <div class="form-row">
                <mat-form-field appearance="outline" class="half-width">
                  <mat-label>City*</mat-label>
                  <input matInput formControlName="city" required>
                </mat-form-field>
                <mat-form-field appearance="outline" class="half-width">
                  <mat-label>State*</mat-label>
                  <input matInput formControlName="state" required>
                </mat-form-field>
              </div>
              <div class="form-row">
                <mat-form-field appearance="outline" class="full-width">
                  <mat-label>Zip Code*</mat-label>
                  <input matInput formControlName="zipCode" required>
                </mat-form-field>
              </div>
              <div class="form-row">
                <mat-form-field appearance="outline" class="full-width">
                  <mat-label>Description*</mat-label>
                  <textarea matInput formControlName="description" rows="3" placeholder="Enter a description..."></textarea>
                </mat-form-field>
              </div>
              <!-- Billing Address -->
              <mat-card class="form-section">
                <mat-card-header>
                  <mat-card-title>Billing Address</mat-card-title>
                </mat-card-header>
                <mat-card-content>
                  <div class="form-row">
                    <mat-checkbox formControlName="sameAsShipping" (change)="onSameAsShippingChange($event)">
                      Same as shipping address
                    </mat-checkbox>
                  </div>
                  <div *ngIf="!checkoutForm.get('sameAsShipping')?.value">
                    <div class="form-row">
                      <mat-form-field appearance="outline" class="full-width">
                        <mat-label>Billing Address</mat-label>
                        <input matInput formControlName="billingAddress" required>
                      </mat-form-field>
                    </div>
                  </div>
                </mat-card-content>
              </mat-card>
              <!-- Shipping Method -->
              <mat-card class="form-section">
                <mat-card-header>
                  <mat-card-title>Shipping Method</mat-card-title>
                </mat-card-header>
                <mat-card-content>
                  <mat-radio-group formControlName="shippingMethod">
                    <mat-radio-button value="standard">
                      <div class="shipping-option">
                        <span class="method-name">Standard Shipping</span>
                        <span class="method-price">{{ cart.shippingAmount === 0 ? 'Free' : formatCurrency(cart.shippingAmount) }}</span>
                      </div>
                      <p class="method-description">5-7 business days</p>
                    </mat-radio-button>
                    <mat-radio-button value="express">
                      <div class="shipping-option">
                        <span class="method-name">Express Shipping</span>
                        <span class="method-price">{{ formatCurrency(100000) }}</span>
                      </div>
                      <p class="method-description">2-3 business days</p>
                    </mat-radio-button>
                  </mat-radio-group>
                </mat-card-content>
              </mat-card>
              <!-- Order Notes -->
              <mat-card class="form-section">
                <mat-card-header>
                  <mat-card-title>Order Notes (Optional)</mat-card-title>
                </mat-card-header>
                <mat-card-content>
                  <mat-form-field appearance="outline" class="full-width">
                    <mat-label>Special instructions for your order</mat-label>
                    <textarea matInput formControlName="notes" rows="4"></textarea>
                  </mat-form-field>
                </mat-card-content>
              </mat-card>
              <!-- Submit Button -->
              <div class="checkout-actions">
                <button mat-raised-button color="primary" type="submit" 
                        [disabled]="checkoutForm.invalid || loading" class="place-order-btn">
                  <mat-spinner diameter="20" *ngIf="loading"></mat-spinner>
                  <span *ngIf="!loading">Place Order</span>
                </button>
              </div>
            </form>
          </div>
          <!-- Order Summary -->
          <div class="order-summary">
            <mat-card>
              <mat-card-header>
                <mat-card-title>Order Summary</mat-card-title>
              </mat-card-header>
              <mat-card-content>
                <div class="order-items">
                  <div *ngFor="let item of cart.items" class="order-item">
                    <div class="item-info">
                      <img [src]="getProductImage(item)" [alt]="item.product?.name" class="item-image">
                      <div class="item-details">
                        <h4>{{ item.product?.name }}</h4>
                        <p>Qty: {{ item.quantity }}</p>
                      </div>
                    </div>
                    <div class="item-price">
                      {{ formatCurrency(item.price * item.quantity) }}
                    </div>
                  </div>
                </div>
                <div class="summary-totals">
                  <div class="summary-line">
                    <span>Subtotal</span>
                    <span>{{ formatCurrency(cart.subtotal) }}</span>
                  </div>
                  <div class="summary-line">
                    <span>Tax</span>
                    <span>{{ formatCurrency(cart.taxAmount) }}</span>
                  </div>
                  <div class="summary-line">
                    <span>Shipping</span>
                    <span>{{ cart.shippingAmount === 0 ? 'Free' : formatCurrency(cart.shippingAmount) }}</span>
                  </div>
                  <div class="summary-line total">
                    <span>Total</span>
                    <span>{{ formatCurrency(cart.totalAmount) }}</span>
                  </div>
                </div>
              </mat-card-content>
            </mat-card>
          </div>
        </div>
        <ng-template #emptyCart>
          <div class="empty-cart">
            <h2>Your cart is empty</h2>
            <p>Add some products to your cart before proceeding to checkout.</p>
            <button mat-raised-button color="primary" routerLink="/products">
              Browse Products
            </button>
          </div>
        </ng-template>
      </div>
    </div>
  `,
  styleUrls: ['./checkout.component.scss']
})
export class CheckoutComponent implements OnInit, OnDestroy {
  checkoutForm!: FormGroup;
  cart: Cart = {
    items: [],
    totalItems: 0,
    subtotal: 0,
    taxAmount: 0,
    shippingAmount: 0,
    discountAmount: 0,
    totalAmount: 0
  };
  
  currentUser: User | null = null;
  loading = false;
  discountCode = '';
  private destroy$ = new Subject<void>();

  constructor(
    private formBuilder: FormBuilder,
    private cartService: CartService,
    private orderService: OrderService,
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {}

  ngOnInit(): void {
    this.currentUser = this.authService.getCurrentUser();
    
    if (!this.currentUser) {
      this.router.navigate(['/login'], { queryParams: { returnUrl: '/checkout' } });
      return;
    }

    this.initializeForm();
    
    // Subscribe to cart changes
    this.cartService.cart$
      .pipe(takeUntil(this.destroy$))
      .subscribe(cart => {
        this.cart = cart;
        if (cart.items.length === 0) {
          this.router.navigate(['/cart']);
        }
      });

    // Migrate guest cart if exists
    if (localStorage.getItem('guest_cart')) {
      this.cartService.migrateGuestCartToServer().subscribe();
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  private initializeForm(): void {
    this.checkoutForm = this.formBuilder.group({
      email: [this.currentUser?.email || '', [Validators.required, Validators.email]],
      firstName: [this.currentUser?.firstName || '', [Validators.required]],
      lastName: [this.currentUser?.lastName || '', [Validators.required]],
      phone: [this.currentUser?.phone || '', [Validators.required]],
      phoneCountry: ['IND', [Validators.required]],
      city: ['', [Validators.required]],
      state: ['', [Validators.required]],
      zipCode: ['', [Validators.required]],
      description: ['', [Validators.required]],
      shippingMethod: ['free', [Validators.required]]
    });
  }

  onSameAsShippingChange(event: any): void {
    if (event.checked) {
      this.checkoutForm.get('billingAddress')?.clearValidators();
    } else {
      this.checkoutForm.get('billingAddress')?.setValidators([Validators.required]);
    }
    this.checkoutForm.get('billingAddress')?.updateValueAndValidity();
  }

  onSubmit(): void {
    if (this.checkoutForm.valid && this.cart.items.length > 0) {
      this.loading = true;
      
      const formValue = this.checkoutForm.value;
      
      // Prepare shipping address
      const shippingAddress = `${formValue.shippingAddress}, ${formValue.city}, ${formValue.state} ${formValue.zipCode}, ${formValue.country}`;
      
      // Prepare billing address
      const billingAddress = formValue.sameAsShipping ? shippingAddress : formValue.billingAddress;
      
      // Prepare order data
      const orderData = {
        shippingAddress,
        billingAddress,
        shippingMethod: formValue.shippingMethod,
        notes: formValue.notes
      };

      // Place order
      this.orderService.placeOrder(orderData).subscribe({
        next: (order: Order) => {
          this.loading = false;
          this.snackBar.open('Order placed successfully!', 'Close', { duration: 3000 });
          
          // Clear cart
          this.cartService.clearCart().subscribe();
          
          // Redirect to order confirmation
          this.router.navigate(['/orders', order.id]);
        },
        error: (error) => {
          this.loading = false;
          this.snackBar.open('Failed to place order. Please try again.', 'Close', { duration: 3000 });
        }
      });
    }
  }

  applyDiscount(): void {
    if (this.discountCode.trim()) {
      // Here you would call a service to apply the discount
      this.snackBar.open('Discount code applied successfully', 'Close', { duration: 3000 });
    }
  }

  proceedToPayment(): void {
    if (this.checkoutForm.valid) {
      // Process payment logic here
      this.snackBar.open('Proceeding to payment...', 'Close', { duration: 2000 });
    }
  }

  getProductImage(item: any): string {
    return item.product?.images?.[0]?.imageUrl || 'assets/placeholder.jpg';
  }

  formatCurrency(amount: number): string {
    return this.cartService.formatCurrency(amount);
  }
}