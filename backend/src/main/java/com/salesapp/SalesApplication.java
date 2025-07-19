package com.salesapp;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchDataAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication(exclude = {
    ElasticsearchDataAutoConfiguration.class,
    RedisAutoConfiguration.class,
    RedisRepositoriesAutoConfiguration.class
})
@EnableCaching
@EnableJpaAuditing
public class SalesApplication {

    public static void main(String[] args) {

        Dotenv  dotenv = Dotenv.configure().ignoreIfMissing().load();

        // Set manually if needed
        System.setProperty("MYSQL_DATABASE", dotenv.get("MYSQL_DATABASE"));
        System.setProperty("MYSQL_PUBLIC_URL", dotenv.get("MYSQL_PUBLIC_URL"));
        System.setProperty("MYSQL_ROOT_PASSWORD", dotenv.get("MYSQL_ROOT_PASSWORD"));
        System.setProperty("MYSQL_URL", dotenv.get("MYSQL_URL"));
        System.setProperty("MYSQLDATABASE", dotenv.get("MYSQLDATABASE"));
        System.setProperty("MYSQLHOST", dotenv.get("MYSQLHOST"));
        System.setProperty("MYSQLPASSWORD", dotenv.get("MYSQLPASSWORD"));
        System.setProperty("MYSQLPORT", dotenv.get("MYSQLPORT"));
        System.setProperty("MYSQLUSER", dotenv.get("MYSQLUSER"));
        System.setProperty("JWT_SECRET", dotenv.get("JWT_SECRET"));

        SpringApplication.run(SalesApplication.class, args);
    }
} 