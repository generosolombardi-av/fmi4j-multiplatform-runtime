package io.github.generosolombardi.fmi.example;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class FmiLoaderApplication {

    public static void main(String[] args) {
        SpringApplication.run(FmiLoaderApplication.class, args);
    }

    @Bean
    CommandLineRunner printRuntime() {
        return args -> {
            System.out.println("==================================================");
            System.out.println("FMI4j Spring Boot smoke test");
            System.out.println("java.home = " + System.getProperty("java.home"));
            System.out.println("java.version = " + System.getProperty("java.version"));
            System.out.println("os.name = " + System.getProperty("os.name"));
            System.out.println("os.arch = " + System.getProperty("os.arch"));
            System.out.println("sun.arch.data.model = " + System.getProperty("sun.arch.data.model"));
            System.out.println("==================================================");
        };
    }
}

