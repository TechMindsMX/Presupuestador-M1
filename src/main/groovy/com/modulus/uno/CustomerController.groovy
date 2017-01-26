package com.modulus.uno

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView

@Controller
class CustomerController {

  @Autowired
  CustomerRepository customerRepository

  @RequestMapping("/")
  ModelAndView index() {
    println "*"*50
    println customerRepository.findAll()
    println customerRepository.findByFirstName("Carlo")
    println "*"*50
    new ModelAndView("index")
  }
}
