package com.modulus.uno
import org.springframework.data.mongodb.repository.MongoRepository

interface CustomerRepository extends MongoRepository<Customer, String> {

  Customer findByFirstName(String firstName)
  Customer findAllByFirstNameiAndLastName(String firstName String lastName)
  List<Customer> findByLastName(String lastName)

}
