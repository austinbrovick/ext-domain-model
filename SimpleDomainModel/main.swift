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

print("Austin Brovick")

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
        return Int(round(Double(self.amount) * self.conversions[from]![to]!))
    }
    
    public func add(_ to: Money) -> Money {
        if (to.currency != self.currency) {
//            let newAmount = to.convert(self.currency).amount
            let newAmount = self.convert(to.currency).amount
            return Money(amount: newAmount + to.amount, currency: to.currency)
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



let tenUSD = Money(amount: 10, currency: "USD")
let twelveUSD = Money(amount: 12, currency: "USD")
let fiveGBP = Money(amount: 5, currency: "GBP")
let fifteenEUR = Money(amount: 15, currency: "EUR")
let fifteenCAN = Money(amount: 15, currency: "CAN")


let total = tenUSD.add(fiveGBP)
print(total.amount)
print(total.amount == 10)
print(total.currency == "GBP")

//////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType

    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }

    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }

    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let hourly):
            return Int(hourly) * hours
        case .Salary(let salary):
            return Int(salary)
        }
    }

    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let hourly):
            self.type = Job.JobType.Hourly(hourly + amt)
        case .Salary(let salary):
            self.type = Job.JobType.Salary(salary + Int(amt))
        }
    }
}



//
//////////////////////////////////////
//// Person
////

open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
    
  open var job : Job? {
    get { return self._job }
    set(value) {
        if self.age > 15 {
            self._job = value
        }
    }
  }

  fileprivate var _spouse : Person? = nil
    
    open var spouse : Person? {
        get { return self._spouse }
        set(value) {
            if self.age > 15 {
                self._spouse = value
            }
        }
    }

    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self._job) spouse:\(self._spouse)]"
    }
}





////////////////////////////////////
// Family

open class Family {
  fileprivate var members : [Person] = []

    public init(spouse1: Person, spouse2: Person) {
        members.append(spouse1)
        members.append(spouse2)
    }

    open func haveChild(_ child: Person) -> Bool {
        members.append(child)
        return true
        
    }

    open func householdIncome() -> Int {
        var income = 0
        for x in members {
            if x._job != nil {
                switch x._job!.type {
                case .Salary(let salary):
                    income += salary
                case .Hourly(let hourly):
                    income += Int(hourly * 2000.0)
                }
            }
        }
        return income
    }
}






