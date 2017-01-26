package com.modulus.uno

import org.springframework.boot.ApplicationRunner
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication

@SpringBootApplication
class Application implements ApplicationRunner {

  static void main(String[] args) {
    SpringApplication.run(Application.class, args)
  }

  @Override
  void run(ApplicationArguments args) throws Exception {
  }

}
