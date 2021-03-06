//
//  Chocoemon.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/03/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class HersheyChocolateDrink: Milk {
    private enum Quantity {
        static let minHighCacaoRate = 0.05
    }
    
    private let cacaoContentRate: Double
    
    init(
        cacaoContentRate: Double,
        name: String,
        volume: Int,
        price: Int,
        manufacturingDate: Date = Date()
    ) {
        self.cacaoContentRate = cacaoContentRate
        super.init(
            brand: "허쉬초콜릿드링크",
            name: name,
            volume: volume,
            price: price,
            manufacturingDate: manufacturingDate
        )
    }
    
    override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(cacaoContentRate)
    }
    
    func isHighCacao() -> Bool {
        return cacaoContentRate >= Quantity.minHighCacaoRate
    }
}

extension HersheyChocolateDrink {
    override var description: String {
        return super.description + ", 카카오: \(cacaoContentRate)%"
    }
}
