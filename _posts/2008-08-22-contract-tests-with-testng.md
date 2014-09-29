---
title: 'Contract Tests with TestNG: unit testing against interfaces and abstract classes'
author: David Soergel
layout: post
permalink: /2008/08/22/contract-tests-with-testng/
categories:
  - Java
---
An aspect of testing Java programs that seems to me fairly neglected is testing conformance to interfaces, and (nearly identically) testing that functionality of abstract classes works properly in all concrete subclasses. Certainly this has [been][1] [mentioned][2] [before][3], generally under the name **Abstract Tests** or **Contract Tests**. Also, the idea seems to me very much in keeping with [Behaviour Driven Development][4] (BDD) and the [Design by Contract][5] (DbC) philosophy.

TestNG does not explicitly support Contract Tests, as far as I can tell, but it’s fairly easy to make it work using the little trick I describe below.

<!--more-->For an interface or abstract class called FooBar, make a test class called FooBarInterfaceTest or FooBarAbstractTest or whatever.

For an implementation FooBarImpl, we could make a test FooBarImplTest that just inherits from FooBarInterfaceTest. But what if FooBarImpl implements multiple interfaces, or extends an abstract class in addition to implementing one or more interfaces?

I thought about making one inner class (inside FooBarImplTest) per interface, each inheriting from the appropriate InterfaceTest. But, that doesn’t work because TestNG doesn’t recognize tests inside inner classes (or even static inner classes).

My solution is to use the TestNG @Factory annotation, which marks a method that returns a bunch of test cases in an object array. We can put such a @Factory in the implementation test class, and use it to return Contract Tests for each of the implemented interfaces or extended abstract classes.

Since the abstract tests will need to create instances of the concrete implementation being tested, we’ll need to provide the abstract test case with a factory for the test instances. I use a simple generic interface to describe the factory:

    public interface TestInstanceFactory<T>
        {
        T createInstance() throws Exception;
        }
    

Then the Contract Test looks like this:

    public abstract class FooBarInterfaceTest
        {
        private TestInstanceFactory<? extends FooBar> tif;
    
        public FooBarInterfaceTest(TestInstanceFactory<? extends FooBar> tif)
            {
            this.tif = tif;
            }
    
        @Test
        public void someFooBarMethodTest
            {
            FooBar testInstance = tif.createInstance();
    
            ... 
            }
        }
    

That creates the problem that the only constructor for the FooBarInterfaceTest requires a TestInstanceFactory argument. If FooBarInterfaceTest were a regular class, then TestNG (or at least the IntelliJ IDEA plugin) would try to instantiate it as a regular test, failing because there’s no zero-arg constructor. The trick there is to make the Contract Test class actually abstract, as indicated above, and to concretize it inline in the @Factory method in the implementation test (see below).

I put some logic for collecting all the Contract Tests relevant to a given implementation test into an abstract class (from which the implementation test will inherit):

    public abstract class ContractTestAware<T>
        {
        public abstract void addContractTestsToQueue(Queue<Object> theContractTests);
    
        @Factory
        public Object[] instantiateAllContractTests()
            {
            Set<Object> result = new HashSet<Object>();
            Queue<Object> queue = new LinkedList<Object>();
    
            addContractTestsToQueue(queue);
    
            // recursively find all applicable contract tests up the tree
            while (!queue.isEmpty())
                {
                Object contractTest = queue.remove();
                result.add(contractTest);
                if (contractTest instanceof ContractTestAware)
                    {
                    ((ContractTestAware) contractTest).addContractTestsToQueue(queue);
                    }
                }
    
            return result.toArray();
            }
        }
    

And finally we make the implementation test, thus:

    public class FooBarImplTest extends ContractTestAware<FooBarImpl>
            implements TestInstanceFactory<FooBarImpl>
        {
        public FooBarImpl createInstance() throws Exception
            {
            return new FooBarImpl();
            }
    
        public void addContractTestsToQueue(Queue<Object> theContractTests)
            {
            theContractTests.add(new FooBarInterfaceTest(this){});  // this is the trick
            }
        }
    

Two problems remain:

1.  although `FooBarImplTest` extends `ContractTestAware`, TestNG [doesn&#8217;t find the inherited `@Factory` method][6]. So we have to override it in `FooBarImplTest`: 
        @Factory
        public Object[] instantiateAllContractTests()
            {
            return super.instantiateAllContractTests();
            }
        

2.  As written above, the `FooBarImplTest` `@Factory` method still [isn&#8217;t found][7] because there is no `@Test` method present. So, in the unfortunate case that you don&#8217;t have any real tests for the implementation class, you can just do this: 
        @Test
        public void bogusTest()
            {
            }
        
    
    that will cause the `@Factory` method to be found so all the Contract Tests will be run.

That’s it! Note you can add as many Contract Tests as you want for each implementation test.

Also, although I’ve emphasized using this approach to test interfaces and abstract classes, there’s no reason you couldn’t use it for regular classes as well. You could do this if you’re in a situation where a subclass ought to pass all of the tests for its superclass (perhaps in addition to tests specific to the subclass).

Note too that this solution is chainable, so the test interface/class hierarchy can mirror the real interface/class hierarchy. For instance, if the `FooBar` interface extends another interface, say `Baz`, then `FooBarInterfaceTest` can itself extend `ContractTestAware` in order to provide a `BazInterfaceTest` (initialized with the provided concrete factory).

    public abstract class FooBarInterfaceTest extends ContractTestAware<FooBar>
        {
        private TestInstanceFactory<? extends FooBar> tif;
    
        public FooBarInterfaceTest(TestInstanceFactory<? extends FooBar> tif)
            {
            this.tif = tif;
            }
    
        public void addContractTestsToQueue(Queue<Object> theContractTests)
            {
            theContractTests.add(new BazInterfaceTest(tif){});
            }
        }
    

Obviously, any change to a Contract Test will be automatically applied wherever it&#8217;s appropriate. That is, by following this methodology, all concrete classes implementing the interface will be always be tested with the current version of the Contract Test.

 [1]: http://blog.paulmoser.co.uk/index.php/2007/02/25/unit-testing-interface-implementations/
 [2]: http://www.ddj.com/184405269
 [3]: http://groboutils.sourceforge.net
 [4]: http://en.wikipedia.org/wiki/Behavior_driven_development
 [5]: http://en.wikipedia.org/wiki/Design_by_contract
 [6]: http://code.google.com/p/testng/issues/detail?id=28
 [7]: http://code.google.com/p/testng/issues/detail?id=29