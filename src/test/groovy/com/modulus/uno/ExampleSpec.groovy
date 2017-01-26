package com.modulus.uno

import spock.lang.Specification
import org.springframework.beans.factory.annotation.Autowired
import java.lang.Void as Should

class ExampleSpec extends Specification {

  Should "Test one to autowired repository"(){
    given:
      def hola = "hola"
    when:
      hola = hola
    then:
      assert true
  }

}
