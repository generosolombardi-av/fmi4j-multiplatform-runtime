package io.github.generosolombardi.fmi.example;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class FmiSmokeController {

    private final FmiSmokeService service;

    public FmiSmokeController(FmiSmokeService service) {
        this.service = service;
    }

    @GetMapping("/fmi/status")
    public Map<String, Object> status() {
        return service.status();
    }

    @PostMapping("/fmi/init")
    public Map<String, Object> init() {
        service.initialize();
        return service.status();
    }

    @PostMapping("/fmi/step")
    public Map<String, Object> step(@RequestParam(defaultValue = "1.0") double size) {
        service.step(size);
        return service.status();
    }
}

