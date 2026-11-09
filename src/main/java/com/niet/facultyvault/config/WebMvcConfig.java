package com.niet.facultyvault.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Expose both /static/ and /webapp/ resources directly to browser
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/static/", "/assets/", "/images/");
    }
}