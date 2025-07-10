import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ProductService } from '../../services/product.service';
import { ProductDTO, Category } from '../../models';
import { CartService } from '../../services/cart.service';
import { Subscription } from 'rxjs';
import { MatDialog } from '@angular/material/dialog';
import { Component as NgComponent, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { AddToCartModalComponent } from '../shared/add-to-cart-modal.component';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.scss']
})
export class ProductListComponent implements OnInit, OnDestroy {
  products: ProductDTO[] = [];
  filteredProducts: ProductDTO[] = [];
  categories: Category[] = [];
  selectedCategory: Category | null = null;
  searchQuery = '';
  sortBy = 'name';
  private sub: Subscription = new Subscription();

  constructor(
    private router: Router,
    private productService: ProductService,
    private cartService: CartService,
    private route: ActivatedRoute,
    private dialog: MatDialog
  ) {}

  ngOnInit() {
    this.sub.add(
      this.productService.getCategories().subscribe(categories => {
        this.categories = categories;
        this.route.queryParams.subscribe(params => {
          const categoryId = +params['category'];
          if (categoryId) {
            this.selectedCategory = this.categories.find(c => c.id === categoryId) || null;
            this.productService.getProductsByCategory(categoryId).subscribe(products => {
              this.products = products;
              this.filteredProducts = [...products];
              this.applyFilters();
              console.log('Products loaded:', products.map(p => ({ name: p.name, stockQuantity: p.stockQuantity, isActive: p.isActive })));
            });
          } else {
            this.selectedCategory = null;
            this.productService.getProducts().subscribe(products => {
              this.products = products;
              this.filteredProducts = [...products];
              this.applyFilters();
              console.log('All products loaded:', products.map(p => ({ name: p.name, stockQuantity: p.stockQuantity, isActive: p.isActive })));
            });
          }
        });
      })
    );
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  addToCart(product: ProductDTO) {
    const dialogRef = this.dialog.open(AddToCartModalComponent, {
      width: '600px',
      maxWidth: '90vw',
      data: { product: product as any },
      panelClass: 'add-to-cart-modal-panel'
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result?.success) {
        console.log('Product added to cart successfully');
      }
    });
  }

  isOutOfStock(product: ProductDTO): boolean {
    const stockQty = Number(product.stockQuantity) || 0;
    const isActive = product.isActive !== false; // Default to true if undefined
    const result = !isActive || stockQty <= 0;
    console.log(`Product ${product.name}: isActive=${product.isActive} (${typeof product.isActive}), stockQuantity=${product.stockQuantity} (${typeof product.stockQuantity}), parsed stockQty=${stockQty}, computed isActive=${isActive}, isOutOfStock=${result}`);
    return result;
  }

  getProductImageUrl(product: ProductDTO): string {
    if (product.images && product.images.length > 0) {
      const url = product.images[0].imageUrl;
      if (url && url.startsWith('/uploads/')) {
        return this.getBackendBaseUrl() + url;
      }
      return url;
    }
    return 'assets/placeholder.jpg';
  }

  openImageModal(product: ProductDTO) {
    this.dialog.open(ProductImageModalComponent, {
      data: { images: product.images, name: product.name },
      width: '600px'
    });
  }

  goToCart(): void {
    this.router.navigate(['/cart']);
  }

  onSearchChange(): void {
    this.applyFilters();
  }

  onSortChange(): void {
    this.applyFilters();
  }

  applyFilters(): void {
    let filtered = [...this.products];

    // Apply search filter
    if (this.searchQuery.trim()) {
      const query = this.searchQuery.toLowerCase();
      filtered = filtered.filter(product => 
        product.name.toLowerCase().includes(query) ||
        product.description?.toLowerCase().includes(query)
      );
    }

    // Apply sorting
    switch (this.sortBy) {
      case 'name':
        filtered.sort((a, b) => a.name.localeCompare(b.name));
        break;
      case 'price-low':
        filtered.sort((a, b) => a.price - b.price);
        break;
      case 'price-high':
        filtered.sort((a, b) => b.price - a.price);
        break;
      case 'newest':
        filtered.sort((a, b) => new Date(b.createdAt || '').getTime() - new Date(a.createdAt || '').getTime());
        break;
    }

    this.filteredProducts = filtered;
  }

  shopAll() {
    this.selectedCategory = null;
    this.productService.getProducts().subscribe(products => {
      this.products = products;
      this.filteredProducts = [...products];
      this.applyFilters();
    });
  }

  reloadProducts() {
    if (this.selectedCategory) {
      this.productService.getProductsByCategory(this.selectedCategory.id).subscribe(products => {
        this.products = products;
        this.filteredProducts = [...products];
        this.applyFilters();
      });
    } else {
      this.productService.getProducts().subscribe(products => {
        this.products = products;
        this.filteredProducts = [...products];
        this.applyFilters();
      });
    }
  }

  getBackendBaseUrl(): string {
    return environment.apiUrl.replace(/\/api$/, '');
  }
}

@NgComponent({
  selector: 'app-product-image-modal',
  template: `
    <h2 mat-dialog-title>{{ data.name }}</h2>
    <mat-dialog-content>
      <div *ngIf="data.images && data.images.length > 0">
        <img [src]="getImageUrl(data.images[0].imageUrl)" [alt]="data.name" style="max-width: 100%; max-height: 400px; border-radius: 8px;" />
        <div class="thumbnail-images" *ngIf="data.images.length > 1">
          <img *ngFor="let image of data.images" [src]="getImageUrl(image.imageUrl)" [alt]="data.name" style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; margin: 4px; cursor: pointer; border: 2px solid #eee;" />
        </div>
      </div>
      <div *ngIf="!data.images || data.images.length === 0">
        <p>No images available.</p>
      </div>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-button mat-dialog-close>Close</button>
    </mat-dialog-actions>
  `,
  styles: []
})
export class ProductImageModalComponent {
  constructor(@Inject(MAT_DIALOG_DATA) public data: { images: any[], name: string }) {}
  getImageUrl(url: string): string {
    if (url && url.startsWith('/uploads/')) {
      return this.getBackendBaseUrl() + url;
    }
    return url;
  }

  getBackendBaseUrl(): string {
    return environment.apiUrl.replace(/\/api$/, '');
  }
}