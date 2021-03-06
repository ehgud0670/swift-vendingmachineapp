//
//  Coffee.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/03/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

class Coffee: Beverage {
    private enum Quantity {
        static let minHotCelsius = 60
    }
    
    private let celsius: Int
    
    init(
        celsius: Int,
        brand: String,
        name: String,
        volume: Int,
        price: Int,
        manufacturingDate: Date
    ) {
        self.celsius = celsius
        super.init(
            brand: brand,
            name: name,
            volume: volume,
            price: price,
            manufacturingDate: manufacturingDate
        )
    }
    
    func isHot() -> Bool {
        return celsius >= Quantity.minHotCelsius
    }
}

extension Coffee {
    override var description: String {
        return super.description + ", \(celsius)°C"
    }
}
