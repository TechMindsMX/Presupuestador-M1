package com.modulus.uno
import org.springframework.data.mongodb.repository.MongoRepository

interface CustomerRepository extends MongoRepository<Customer, String> {

  Customer findByFirstName(String firstName)
  List<Customer> findByLastName(String lastName)

}
