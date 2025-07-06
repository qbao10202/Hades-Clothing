@echo off
echo Updating Sales Application Database...
echo ======================================

REM Check if MySQL is running
mysql --version >nul 2>&1
if errorlevel 1 (
    echo Error: MySQL is not installed or not in PATH
    echo Please install MySQL or add it to your PATH
    pause
    exit /b 1
)

REM Run the migration script
echo Running database migration...
mysql -u root -p sales_app < mysql/migration.sql

if errorlevel 1 (
    echo Error: Failed to run migration script
    echo Please check your MySQL connection and try again
    pause
    exit /b 1
)

echo.
echo Database migration completed successfully!
echo.
echo The following updates were made:
echo - Added permissions table
echo - Added role_permissions junction table
echo - Inserted default permissions
echo - Assigned permissions to roles
echo - Ensured admin user has admin role
echo.
echo You can now start your application with the new role-based system.
pause 