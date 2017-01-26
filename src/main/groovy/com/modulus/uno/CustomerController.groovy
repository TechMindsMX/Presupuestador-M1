package com.modulus.uno

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView

@Controller
class CustomerController {

  @RequestMapping("/")
  ModelAndView index() {
    new ModelAndView("index")
  }
}
