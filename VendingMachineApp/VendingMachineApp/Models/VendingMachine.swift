//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/03/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct VendingMachine {
    
    private var stock: [Beverage]
    private var cashier = Cashier()
    
    init(stock: [Beverage] = []) {
        self.stock = stock
    }
    
    mutating func receive(insertedMoney: Int) {
        cashier.plus(money: insertedMoney)
    }
    
    func currentMoney() -> Int {
        return cashier.currentBalance
    }
    
    mutating func addToStock(beverage: Beverage) {
        stock.append(beverage)
    }
    
    @discardableResult
    mutating func sell(wantedBeverage: Beverage) -> Beverage? {
        guard cashier.isEnoughToBuy(price: wantedBeverage.price),
            subtractFromStock(beverage: wantedBeverage)
            else {
                return nil
        }
        
        cashier.addToSalesLog(beverage: wantedBeverage)
        cashier.subtract(price: wantedBeverage.price)
        return wantedBeverage
    }
    
    mutating private func subtractFromStock(beverage: Beverage) -> Bool {
        for index in 0 ..< stock.count {
            if stock[index] === beverage {
                stock.remove(at: index)
                return true
            }
        }
        return false
    }
    
    func stockByKind() -> [String: [Beverage]] {
        var stockByKind = [String: [Beverage]]()
        stock.forEach {
            let typeToString = "\(type(of: $0))"
            guard !stockByKind.keys.contains(typeToString)
                else {
                    stockByKind[typeToString]?.append($0)
                    return
            }
            stockByKind[typeToString] = [$0]
        }
        return stockByKind
    }
    
    func sellableBeverages() -> [String: [Beverage]] {
        var sellableBeverages = [String: [Beverage]]()
        stock.forEach {
            let typeToString = "\(type(of: $0))"
            guard !sellableBeverages.keys.contains(typeToString)
                else {
                    sellableBeverages[typeToString]?.append($0)
                    return
            }
            guard cashier.isEnoughToBuy(price: $0.price)
                else {
                    return
            }
            sellableBeverages[typeToString] = [$0]
        }
        return sellableBeverages
    }
    
}

extension VendingMachine {
    
    func searchSalesLog(handler: (Beverage) -> (Void)) {
        cashier.searchSalesLog { handler($0) }
    }
    
    func searchHotCoffees(handler: (Coffee) -> (Void)) {
        stock.filter { (beverage) -> Bool in
            guard let hotCoffee = beverage as? Coffee, hotCoffee.isHot()
                else {
                    return false
            }
            return true
        }.forEach {
            let hotCoffee = $0 as! Coffee
            handler(hotCoffee)
        }
    }
    
    func searchMilksPassed(expirationDate: Date, handler: (Milk) -> (Void)) {
        stock.filter { (beverage) -> Bool in
            guard let milkPassedExpirationDate = beverage as? Milk,
                !milkPassedExpirationDate.validate(with: expirationDate)
                else {
                    return false
            }
            return true
        }.forEach {
            let verifiedMilk = $0 as! Milk
            handler(verifiedMilk)
        }
    }
    
    func searchAllBeverages(handler: (Beverage) -> (Void)) {
        stock.forEach { handler($0) }
    }
    
}
