package com.salesapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchDataAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication(exclude = {
    ElasticsearchDataAutoConfiguration.class,
    RedisAutoConfiguration.class,
    RedisRepositoriesAutoConfiguration.class
})
@EnableCaching
public class SalesApplication {

    public static void main(String[] args) {
        SpringApplication.run(SalesApplication.class, args);
    }
} 