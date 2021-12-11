//
//  Basket.swift
//  Clothes Store
//
//  Created by Robin Phillips on 11/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

struct Basket {
    static var items: [BasketItem] = []
}

struct BasketItem {
    var numberOfItems: Int = 1
    
    let product: Product
}
