package fr.orleans.m1.wsi.versements;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class VersementsApplication {

    public static void main(String[] args) {
        SpringApplication.run(VersementsApplication.class, args);
    }

}
