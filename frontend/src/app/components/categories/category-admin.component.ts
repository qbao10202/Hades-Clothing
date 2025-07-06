import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatTableDataSource } from '@angular/material/table';
import { SelectionModel } from '@angular/cdk/collections';
import { Category } from '../../models';
import { CategoryService } from '../../services/category.service';
import { CategoryFormModalComponent } from './category-form-modal.component';
import { DeleteConfirmationComponent } from '../shared/delete-confirmation.component';

@Component({
  selector: 'app-category-admin',
  templateUrl: './category-admin.component.html',
  styleUrls: ['./category-admin.component.scss']
})
export class CategoryAdminComponent implements OnInit {
  categories: Category[] = [];
  dataSource = new MatTableDataSource<Category>();
  selection = new SelectionModel<Category>(true, []);
  loading = false;
  displayedColumns: string[] = ['select', 'image', 'name', 'createdAt', 'actions'];
  searchText = '';

  constructor(
    private categoryService: CategoryService,
    private dialog: MatDialog,
    private snackBar: MatSnackBar
  ) {}

  ngOnInit(): void {
    this.loadCategories();
  }

  loadCategories(): void {
    this.loading = true;
    this.categoryService.getCategories().subscribe({
      next: (data) => {
        this.categories = data;
        this.dataSource.data = data;
        this.applyFilter();
        this.loading = false;
      },
      error: (error) => {
        console.error('Error loading categories:', error);
        this.loading = false;
      }
    });
  }

  applyFilter(): void {
    const filterValue = this.searchText.trim().toLowerCase();
    this.dataSource.filter = filterValue;
  }

  addCategory(): void {
    const dialogRef = this.dialog.open(CategoryFormModalComponent, {
      width: '800px',
      maxWidth: '90vw',
      data: { 
        category: null, 
        parentCategories: this.categories 
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.categoryService.createCategory(result).subscribe({
          next: (newCategory) => {
            this.categories = [newCategory, ...this.categories];
            this.dataSource.data = this.categories;
            this.snackBar.open('Category added successfully!', 'Close', { duration: 3000 });
          },
          error: (error) => {
            console.error('Error creating category:', error);
            this.snackBar.open('Error creating category', 'Close', { duration: 3000 });
          }
        });
      }
    });
  }

  editCategory(category: Category): void {
    const dialogRef = this.dialog.open(CategoryFormModalComponent, {
      width: '800px',
      maxWidth: '90vw',
      data: { 
        category: category, 
        parentCategories: this.categories.filter(c => c.id !== category.id) 
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.categoryService.updateCategory(category.id, result).subscribe({
          next: (updatedCategory) => {
            const index = this.categories.findIndex(c => c.id === category.id);
            if (index !== -1) {
              this.categories[index] = updatedCategory;
              this.dataSource.data = this.categories;
            }
            this.snackBar.open('Category updated successfully!', 'Close', { duration: 3000 });
          },
          error: (error) => {
            console.error('Error updating category:', error);
            this.snackBar.open('Error updating category', 'Close', { duration: 3000 });
          }
        });
      }
    });
  }

  deleteCategory(category: Category): void {
    const dialogRef = this.dialog.open(DeleteConfirmationComponent, {
      width: '400px',
      data: { 
        title: 'Delete Category', 
        message: `Are you sure you want to delete "${category.name}"?` 
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.categoryService.deleteCategory(category.id).subscribe({
          next: () => {
            this.categories = this.categories.filter(c => c.id !== category.id);
            this.dataSource.data = this.categories;
            this.snackBar.open('Category deleted successfully!', 'Close', { duration: 3000 });
          },
          error: (error) => {
            console.error('Error deleting category:', error);
            this.snackBar.open('Error deleting category', 'Close', { duration: 3000 });
          }
        });
      }
    });
  }

  // Selection methods
  isAllSelected(): boolean {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.data.length;
    return numSelected === numRows;
  }

  masterToggle(): void {
    this.isAllSelected() ?
      this.selection.clear() :
      this.dataSource.data.forEach(row => this.selection.select(row));
  }

  // Bulk actions
  bulkDelete(): void {
    const selectedCategories = this.selection.selected;
    const dialogRef = this.dialog.open(DeleteConfirmationComponent, {
      width: '400px',
      data: { 
        title: 'Delete Categories', 
        message: `Are you sure you want to delete ${selectedCategories.length} categories?` 
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        const deletePromises = selectedCategories.map(category => 
          this.categoryService.deleteCategory(category.id).toPromise()
        );
        
        Promise.all(deletePromises).then(() => {
          this.loadCategories();
          this.selection.clear();
          this.snackBar.open('Categories deleted successfully!', 'Close', { duration: 3000 });
        }).catch(error => {
          console.error('Error deleting categories:', error);
          this.snackBar.open('Error deleting categories', 'Close', { duration: 3000 });
        });
      }
    });
  }

  bulkActivate(): void {
    const selectedCategories = this.selection.selected;
    const updatePromises = selectedCategories.map(category => 
      this.categoryService.updateCategory(category.id, { ...category, isActive: true }).toPromise()
    );
    
    Promise.all(updatePromises).then(() => {
      this.loadCategories();
      this.selection.clear();
      this.snackBar.open('Categories activated successfully!', 'Close', { duration: 3000 });
    }).catch(error => {
      console.error('Error activating categories:', error);
      this.snackBar.open('Error activating categories', 'Close', { duration: 3000 });
    });
  }

  bulkDeactivate(): void {
    const selectedCategories = this.selection.selected;
    const updatePromises = selectedCategories.map(category => 
      this.categoryService.updateCategory(category.id, { ...category, isActive: false }).toPromise()
    );
    
    Promise.all(updatePromises).then(() => {
      this.loadCategories();
      this.selection.clear();
      this.snackBar.open('Categories deactivated successfully!', 'Close', { duration: 3000 });
    }).catch(error => {
      console.error('Error deactivating categories:', error);
      this.snackBar.open('Error deactivating categories', 'Close', { duration: 3000 });
    });
  }

  getImageUrl(imageUrl: string): string {
    if (!imageUrl) return '';
    if (imageUrl.startsWith('http')) return imageUrl;
    if (imageUrl.startsWith('/uploads')) return `http://localhost:8080${imageUrl}`;
    return `http://localhost:8080/uploads/categories/${imageUrl}`;
  }
} 