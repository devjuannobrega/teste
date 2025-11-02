package com.example.demo.service;

import com.example.demo.model.HealthDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class HealthService {

    public ResponseEntity<HealthDTO> getHealth() {
        HealthDTO teste = new HealthDTO();
        teste.setStatus("OK");
        teste.setMessage("Api Online");
        return ResponseEntity.ok(teste);
    }
}
