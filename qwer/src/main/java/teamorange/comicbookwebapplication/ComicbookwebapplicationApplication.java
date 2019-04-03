package teamorange.comicbookwebapplication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan({"controller"})
@SpringBootApplication
public class ComicbookwebapplicationApplication {

    public static void main(String[] args) {
        SpringApplication.run(ComicbookwebapplicationApplication.class, args);
    }

}
