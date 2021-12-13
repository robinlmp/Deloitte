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
    
    static func addToBasket(productID: String) {
        let products = Products()
        
        // check if there is stock remaining
        guard let productStock = products.products?.first(where: { $0.productId == productID } )?.stock else {
            print("product not found in products")
            return
        }
        
        // checks if the product is in the basket
        if let basketQuantity = items.first(where: { $0.product.productId == productID  })?.numberOfItems {

            if productStock > basketQuantity { // check if there is stock
                    guard let index = items.firstIndex(where: { $0.product.productId == productID }) else { return }
                    items[index].numberOfItems += 1
            } else {
                print("insuffient stock")
            }
            // if it doesn't already exist, add product to basket if there are any in stock
        } else if productStock > 0 {
            if let tempProduct = products.products?.first(where: { $0.productId == productID } ) {
                items.append(BasketItem(product: tempProduct))
            }
        } else {
            print("insuffient stock")
        }
        
    }
    
    static func checkStock(productID: String) -> Int {
        // compare basket contents against stock
        
        return -999
    }
    
    //    static func findProductInBasketByID(productID: String) -> BasketItem {
    //
    //    }
}


struct BasketItem {
    var numberOfItems: Int = 1
    
    let product: Product
    
    //    mutating func addExtraItem() {
    //        numberOfItems += 1
    //    }
    
    //    mutating func addExtraToBasket(productID: String) {
    //        let products = Products()
    //
    //        // check if there is stock remaining
    //        guard let productStock = products.products?.first(where: { $0.productId == productID } )?.stock else { return }
    //        guard let basketQuantity = Basket.items.first(where: { $0.product.productId == productID  })?.numberOfItems else { return }
    //
    //        if productStock > basketQuantity && basketQuantity > 0 {
    //            // check if item aleady exists in basket add item to basket or BasketItem.numberOfItems +1
    //                addExtraItem()
    //
    //
    //        }
    //
    //    }
    
    
}
