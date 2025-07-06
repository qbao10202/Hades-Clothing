package com.salesapp.controller;

import com.salesapp.dto.DashboardStatsResponse;
import com.salesapp.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin(origins = "*")
public class DashboardController {
    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/stats")
    public DashboardStatsResponse getDashboardStats() {
        return dashboardService.getDashboardStats();
    }
} 