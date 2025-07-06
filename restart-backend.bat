@echo off
echo Stopping any existing Java processes...
taskkill /F /IM java.exe >nul 2>&1

echo Starting Spring Boot backend...
cd /d "e:\WEB ANH TRUNG\backend"
java -jar target/sales-backend-1.0.0.jar

pause
