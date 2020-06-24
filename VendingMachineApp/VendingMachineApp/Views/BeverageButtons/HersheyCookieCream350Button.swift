//
//  HersheyCookieCream350Button.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class HersheyCookieCream350Button: BeverageButton {
    override func instantiator() -> BeverageInstantiator? {
        return HersheyCookieCream350Instantiator()
    }
}
