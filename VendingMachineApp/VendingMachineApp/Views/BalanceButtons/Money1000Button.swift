//
//  Balance1000Button.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/06/09.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class Money1000Button: MoneyButton {
    override var instantiator: MoneyInstantiator? {
        return Money1000Instantiator()
    }
}
