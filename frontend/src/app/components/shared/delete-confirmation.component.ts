import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

export interface DeleteConfirmationData {
  title: string;
  message: string;
  itemName?: string;
}

@Component({
  selector: 'app-delete-confirmation',
  template: `
    <div class="delete-confirmation-dialog">
      <div class="dialog-header">
        <mat-icon class="warning-icon">warning</mat-icon>
        <h2 mat-dialog-title>{{ data.title }}</h2>
      </div>
      
      <div mat-dialog-content class="dialog-content">
        <p>{{ data.message }}</p>
        <div *ngIf="data.itemName" class="item-name">
          <strong>{{ data.itemName }}</strong>
        </div>
        <p class="warning-text">This action cannot be undone.</p>
      </div>
      
      <div mat-dialog-actions class="dialog-actions">
        <button mat-button (click)="onCancel()" class="cancel-btn">
          Cancel
        </button>
        <button mat-raised-button color="warn" (click)="onDelete()" class="delete-btn">
          Delete
        </button>
      </div>
    </div>
  `,
  styles: [`
    .delete-confirmation-dialog {
      max-width: 400px;
      text-align: center;
    }
    
    .dialog-header {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 20px;
    }
    
    .warning-icon {
      font-size: 48px;
      width: 48px;
      height: 48px;
      color: #ff5722;
      margin-bottom: 16px;
    }
    
    .dialog-content {
      margin-bottom: 20px;
    }
    
    .item-name {
      background: #f5f5f5;
      padding: 10px;
      border-radius: 4px;
      margin: 10px 0;
      font-family: monospace;
    }
    
    .warning-text {
      color: #666;
      font-size: 14px;
      font-style: italic;
    }
    
    .dialog-actions {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }
    
    .cancel-btn {
      color: #666;
    }
    
    .delete-btn {
      background: #f44336;
      color: white;
    }
  `]
})
export class DeleteConfirmationComponent {
  constructor(
    public dialogRef: MatDialogRef<DeleteConfirmationComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DeleteConfirmationData
  ) {}

  onCancel(): void {
    this.dialogRef.close(false);
  }

  onDelete(): void {
    this.dialogRef.close(true);
  }
}
