package com.example.demo.controller;


import com.example.demo.model.HealthDTO;
import com.example.demo.service.HealthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class Health {

    private final HealthService healthService;

    @GetMapping("/health")
    public ResponseEntity<HealthDTO> getHealth() {
        return healthService.getHealth();
    }
}
