//
//  HersheyCookieCream235Label.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class HersheyCookieCream235Label: BeverageLabel {
    override func beverage() -> Beverage? {
        return HersheyChocolateDrink(
            cacaoContentRate: 0.03,
            name: "쿠키앤크림",
            volume: 235,
            price: 1300
        )
    }
}