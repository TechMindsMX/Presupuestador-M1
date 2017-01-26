package com.modulus.uno

import org.springframework.data.annotation.Id

class Customer {

  @Id
  String id
  String firstName
  String lastName


  @Override
  String toString() {
    return String.format(
      "Customer[id=%s, firstName='%s', lastName='%s']",
      id, firstName, lastName)
  }

}
