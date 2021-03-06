//
//  Soda.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/03/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

class Soda: Beverage {
    private enum Quantity {
        static let maxLowKiloCalorie = 100
    }
    private let kiloCalorie: Int
    
    init(
        kiloCalorie: Int,
        brand: String,
        name: String,
        volume: Int,
        price: Int,
        manufacturingDate: Date
    ) {
        self.kiloCalorie = kiloCalorie
        super.init(
            brand: brand,
            name: name,
            volume: volume,
            price: price,
            manufacturingDate: manufacturingDate
        )
    }
    
    override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(kiloCalorie)
    }
    
    func isLowCalorie() -> Bool {
        return kiloCalorie <= Quantity.maxLowKiloCalorie
    }
}

extension Soda {
    override var description: String {
        return super.description + ", \(kiloCalorie)kcal"
    }
}
