abstract class Class1Api {
  method1();
  method2();
  //...
}

class Class1 implements Class1Api {
  noSuchMethod(Invocation inv) {
    //...
  }
}

main() {
  Class1 cl = new Class1();
  // cl.  // remove comment and type cl. to see method1()
          // and so on in code completion
}