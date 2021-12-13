//
//  Basket.swift
//  Clothes Store
//
//  Created by Robin Phillips on 11/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit
import Combine


class Basket {
    static var items: [BasketItem] = []
    static var wishListItems: [BasketItem] = []
    

    static var totalInBasket: Int { Basket.items.map( { $0.numberOfItems } ).reduce(0, +) }
    
    @Published var totalInBasketPublished = String(calculateTotalItemsInBasket())
    
    
    
    
    static func calculateTotalItemsInBasket() -> Int {
        return Basket.items.map( { $0.numberOfItems } ).reduce(0, +)
    }
    
    
    static func calculateBasketTotalCost() -> String {
        return "$" + String(format: "%.2f", Basket.items
                        .map( { ($0.product.price ?? 0 ) * Float($0.numberOfItems) } )
                        .reduce(Float(0), +))
    }
    
    
    static func removeFromBasket(product: Product) {
        items.removeAll(where: { $0.product.productId == product.productId })
    }
    
    
    static func addToBasket(product: Product) {
        
        // check if there is stock remaining
        guard let productStock = product.stock else {
            print("product not found in products")
            return
        }
        
        // checks if the product is in the basket
        if let basketQuantity = items.first(where: { $0.product.productId == product.productId  })?.numberOfItems {

            if productStock > basketQuantity { // check if there is stock
                guard let index = items.firstIndex(where: { $0.product.productId == product.productId }) else { return }
                    items[index].numberOfItems += 1
            } else {
                print("insuffient stock")
            }
            // if it doesn't already exist, add product to basket if there are any in stock
        } else if productStock > 0 {
                items.append(BasketItem(product: product))
        } else {
            print("insuffient stock")
        }
    }
    
    static func addToWishList(product: Product) {
        guard items.first(where: { $0.product.productId == product.productId  })?.numberOfItems == nil else { return }
        
        wishListItems.append(BasketItem(product: product))
    }
    
    static func removeFromWishList(product: Product) {
        guard items.first(where: { $0.product.productId == product.productId  })?.numberOfItems != nil else { return }
        
        guard let index = wishListItems.firstIndex(where: { $0.product.productId == product.productId }) else { return }
        wishListItems.remove(at: index)
    }
    
    
    static func checkStock(product: Product?) -> Int? {
        guard let product = product else { return nil }

        // compare basket contents against stock
        guard let stock = product.stock else { return nil }
        if let basketQuantity = items.first(where: { $0.product.productId == product.productId  })?.numberOfItems {
            return stock - basketQuantity
        }
        return stock
    }
    
}


class BasketItem {
    var numberOfItems: Int = 1
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
}
