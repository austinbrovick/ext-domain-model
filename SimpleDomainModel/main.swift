//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//



// 1 USD = .5 GBP (2 USD = 1 GBP)
// 1 USD = 1.5 EUR (2 USD = 3 EUR)
// 1 USD = 1.25 CAN (4 USD = 5 CAN)

import Foundation

print("Hello, World!1234")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    public let conversions: [String: [String: Double]] = [
        "USD": ["GBP": 0.5, "EUR": 1.5, "CAN": 1.25],
        "EUR": ["USD": 0.66, "GBP": 0.33, "CAN": 0.83],
        "CAN": ["USD": 0.8, "GBP": 0.4, "EUR": 1.2],
        "GBP": ["USD": 2.0, "EUR": 3.0, "CAN": 2.5]
    ]
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
  
    func convert(_ to: String) -> Money {
        return Money(amount: convertHelper(self.currency, to), currency: to)
    }
    
    private func convertHelper(_ from: String, _ to: String) -> Int {
        return Int(self.amount * Int(self.conversions[from]![to]!))
    }
    
    public func add(_ to: Money) -> Money {
        if (to.currency != self.currency) {
            let newAmount = to.convert(self.currency).amount
            return Money(amount: to.amount + newAmount, currency: self.currency)
        }
        return Money(amount: to.amount + self.amount, currency: to.currency)
    }
    
    
    public func subtract(_ from: Money) -> Money {
        if (from.currency != self.currency) {
            let newAmount = from.convert(self.currency).amount
            return Money(amount: newAmount - self.amount, currency: from.currency)
        }
        return Money(amount: self.amount - from.amount, currency: from.currency)
    }
}



//let oneUSD = Money(amount: 1, currency: "USD")
////print(oneUSD.amount)
//let tenGBP = Money(amount: 10, currency: "GBP")
////print(tenGBP.convert("USD").amount)
//
//let tenUSD = Money(amount: 10, currency: "USD")
//let yolo = Money(amount: 20, currency: "GBP")
//
//
//print(yolo.amount)
//
//print(tenUSD.amount)
//print(yolo.convert("USD").amount)
//
//
//
//print(tenUSD.subtract(yolo).amount)


//
//////////////////////////////////////
//// Job
////
//open class Job {
//  fileprivate var title : String
//  fileprivate var type : JobType
//
//  public enum JobType {
//    case Hourly(Double)
//    case Salary(Int)
//  }
//
//  public init(title : String, type : JobType) {
//  }
//
//  open func calculateIncome(_ hours: Int) -> Int {
//  }
//
//  open func raise(_ amt : Double) {
//  }
//}
//
//////////////////////////////////////
//// Person
////
//open class Person {
//  open var firstName : String = ""
//  open var lastName : String = ""
//  open var age : Int = 0
//
//  fileprivate var _job : Job? = nil
//  open var job : Job? {
//    get { }
//    set(value) {
//    }
//  }
//
//  fileprivate var _spouse : Person? = nil
//  open var spouse : Person? {
//    get { }
//    set(value) {
//    }
//  }
//
//  public init(firstName : String, lastName: String, age : Int) {
//    self.firstName = firstName
//    self.lastName = lastName
//    self.age = age
//  }
//
//  open func toString() -> String {
//  }
//}
//
//////////////////////////////////////
//// Family
////
//open class Family {
//  fileprivate var members : [Person] = []
//
//  public init(spouse1: Person, spouse2: Person) {
//  }
//
//  open func haveChild(_ child: Person) -> Bool {
//  }
//
//  open func householdIncome() -> Int {
//  }
//}





