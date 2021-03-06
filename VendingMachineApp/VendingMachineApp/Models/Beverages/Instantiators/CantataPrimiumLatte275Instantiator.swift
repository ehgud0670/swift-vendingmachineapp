//
//  CantataPrimiumLatte275Instantiator.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/06/24.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class CantataPrimiumLatte275Instantiator: BeverageInstantiator {
    override var beverage: Beverage? {
        return Cantata(
            milkContentRate: 0.15,
            sugarContentRate: 0.05,
            celsius: 65,
            name: "프리미엄 라떼",
            volume: 275,
            price: 2200
        )
    }
}
