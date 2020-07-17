//
//  VendingMachineTest.swift
//  VendingMachineAppTests
//
//  Created by kimdo2297 on 2020/03/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import XCTest
@testable import VendingMachineApp

final class VendingMachineTest: XCTestCase {
    private var vendingMachine: VendingMachine!
    private var money: Money!
    private var stock: Stock!
    
    private let primiumLatte = Cantata(
        milkContentRate: 0.15,
        sugarContentRate: 0.05,
        celsius: 65,
        name: "프리미엄 라떼",
        volume: 175,
        price: 1500
    )
    private let dietCola = Pepsi(
        package: Pepsi.Package.can,
        kiloCalorie: 80,
        name: "다이어트 콜라",
        volume: 250,
        price: 1200
    )
    
    private let dietCola2 = Pepsi(
        package: Pepsi.Package.can,
        kiloCalorie: 80,
        name: "다이어트 콜라",
        volume: 250,
        price: 1200
    )
    
    private let cookieCreamMilk = HersheyChocolateDrink(
        cacaoContentRate: 0.03,
        name: "쿠키앤크림",
        volume: 235,
        price: 1300
    )
    
    override func setUp() {
        super.setUp()
        money = Money()
        stock = Stock(beverages: [primiumLatte, dietCola, cookieCreamMilk, dietCola2])
        vendingMachine = VendingMachine(
            stock: stock,
            balance: money
        )
    }
    
    override func tearDown() {
        money = nil
        stock = nil
        vendingMachine = nil
        super.tearDown()
    }
    
    func testReceive() {
        //given
        let money = Money(balance: 2000)
        
        //when
        vendingMachine.receive(insertedMoney: money)
        
        //then
        XCTAssertEqual(self.money, money)
    }
    
    func testCurrentMoney() {
        XCTAssertEqual(self.money, Money())
    }
    
    func testStockByKind() {
        let stockByKind = vendingMachine.stockByKind()
        XCTAssertEqual(stockByKind,
                       [primiumLatte: 1,
                        dietCola: 2,
                        cookieCreamMilk: 1])
    }
    
    func testSellableBeverages() {
        vendingMachine.receive(insertedMoney: Money(balance: 1500))
        
        let sellableBeverages = vendingMachine.sellableBeverages()
        XCTAssertEqual(sellableBeverages,
                       [dietCola: 2, primiumLatte: 1, cookieCreamMilk: 1])
    }
    
    func testSell_success() {
        //given
        vendingMachine.receive(insertedMoney: Money(balance: 1500))
        
        //when
        let result = vendingMachine.sell(wantedBeverage: cookieCreamMilk)
        
        //then
        switch result {
        case .success(let beverage):
            XCTAssertEqual(beverage, cookieCreamMilk)
        default:
            break
        }
    }
    
    func testSell_fail_돈이_부족한_경우() {
        //given
        vendingMachine.receive(insertedMoney: Money(balance: 1000))
        
        //when
        let result = vendingMachine.sell(wantedBeverage: cookieCreamMilk)
        
        //then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, SellError.insufficientMoneyError)
        default:
            break
        }
    }
    
    func testSell_fail_해당_음료가_없는_경우() {
        //given
        vendingMachine.receive(insertedMoney: Money(balance: 10000))
        let other = Cantata(
            milkContentRate: 0.1,
            sugarContentRate: 0.1,
            celsius: 50,
            name: "다른 라떼",
            volume: 100,
            price: 1200
        )
        
        //when
        let result = vendingMachine.sell(wantedBeverage: other)
        
        //then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, SellError.nonExistentBeverageError)
        default:
            break
        }
    }
    
    func testAdd() {
        //given
        vendingMachine = VendingMachine(stock: Stock(), balance: Money())
        let otherCookieCreamMilk = HersheyChocolateDrink(
            cacaoContentRate: 0.03,
            name: "쿠키앤크림",
            volume: 235,
            price: 1300
        )
        
        //when
        vendingMachine.addToStock(beverage: otherCookieCreamMilk)
        
        //then
        vendingMachine.repeatAllBeverages { (beverage) -> (Void) in
            XCTAssertEqual(beverage, otherCookieCreamMilk)
        }
    }
    
    func testSearchSalesLog() {
        vendingMachine.receive(insertedMoney: Money(balance: 1500))
        let result =  vendingMachine.sell(wantedBeverage: cookieCreamMilk)
        switch result {
        case .success(let beverage):
            vendingMachine.repeatSalesLog {
                XCTAssertEqual($0, beverage)
            }
        default:
            break
        }
    }
    
    func testSearchHotCoffees() {
        vendingMachine.repeatHotCoffees {
            XCTAssertEqual($0, primiumLatte)
        }
    }
    
    func testSearchMilksPassed() {
        //given
        let now = Date()
        let cookieCreamMilk = HersheyChocolateDrink(
            cacaoContentRate: 0.03,
            name: "쿠키앤크림",
            volume: 235,
            price: 1300,
            manufacturingDate: now
        )
        vendingMachine = VendingMachine(stock: Stock(beverages: [cookieCreamMilk]), balance: Money())
        
        //then
        let twoWeeksLater = now.addingTimeInterval(TimeInterval(1209600))
        vendingMachine.repeatMilksPassed(expirationDate: twoWeeksLater) {
            XCTAssertEqual($0, cookieCreamMilk)
        }
    }
}
