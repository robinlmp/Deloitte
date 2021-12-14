//
//  Basket.swift
//  Clothes Store
//
//  Created by Robin Phillips on 11/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit
import Combine

// I started off with the target version set to iOS12 and only changed to iOS15 evening 13th Decemember.
// I'm not that experienced with passing data around between view controllers (as I imagine you can see)
// And without access to the Combine wrappers built into SwiftUI, I opted to rely on static properties.
// When I then upped the target to iOS15 to get access to Combine and SwiftUI (for tasks 5 and 6) it
// became clear that this earlier decision wasn't a great one. At the time of writing this I have a few
// hours left and have decided it is better to document what I have done. If I have time I may have
// a go at rejigging things. I think I need to learn more about delegates.
// Started off with Basket as a struct and changed to a class to try to get Combine working.


class Basket: ObservableObject {
    static var items: [BasketItem] = []
    static var wishListItems: [BasketItem] = []
    

    static var totalInBasket: Int { Basket.items.map( { $0.numberOfItems } ).reduce(0, +) }
    
    /// Couldn't get this publisher working. I've not used Combine outside of SwiftUI before
    /// Suspect it is because the method doesn't get called and having modelled everything
    /// else with static properties, I can't make them publishers.
    @Published var totalInBasketPublished = String(calculateTotalItemsInBasket())
    
    
    static func calculateTotalItemsInBasket() -> Int {
        return Basket.items.map( { $0.numberOfItems } ).reduce(0, +)
    }
    
    
    static func calculateBasketTotalCost() -> String {
        return CurrencyHelper.getMoneyString( Basket.items
                        .map( { ($0.product.price ?? 0 ) * Float($0.numberOfItems) } )
                        .reduce(Float(0), +) )
    }
    
    
    static func removeFromBasket(product: Product) {
        items.removeAll(where: { $0.product.productId == product.productId })
    }
    
    
    static func addToBasket(product: Product) {
        
        /// check if there is stock remaining
        guard let productStock = product.stock else {
            print("product not found in products")
            return
        }
        
        /// checks if the product is in the basket
        if let basketQuantity = items.first(where: { $0.product.productId == product.productId  })?.numberOfItems {

            if productStock > basketQuantity { /// check if there is stock
                guard let index = items.firstIndex(where: { $0.product.productId == product.productId }) else { return }
                    items[index].numberOfItems += 1
            } else {
                print("insuffient stock")
            }
            /// if it doesn't already exist, add product to basket if there are any in stock
        } else if productStock > 0 {
                items.append(BasketItem(product: product))
        } else {
            print("insuffient stock")
        }
    }
    
    
    static func addToWishList(product: Product) {
        /// checks that the product doesn't already exist in wishlist
        guard wishListItems.first(where: { $0.product.productId == product.productId })?.numberOfItems == nil else { return }
        wishListItems.append(BasketItem(product: product))
    }
    
    
    static func removeFromWishList(product: Product) {
        /// checks that the product exists in wishlist before trying to remove it. Maybe the first guard isn't required
        guard wishListItems.first(where: { $0.product.productId == product.productId  })?.numberOfItems != nil else { return }
        guard let index = wishListItems.firstIndex(where: { $0.product.productId == product.productId }) else { return }
        wishListItems.remove(at: index)
    }
    
    
    static func moveToBasketFromWishlist(basketItem: BasketItem?) {
        guard let basketItem = basketItem else { return }
        
        /// checks that the BasketItem is in the wishlist before trying to add it to the basket and remove it
        /// from the wishlist
        if let index = wishListItems.firstIndex(where: { $0.product.productId == basketItem.product.productId }) {
            Basket.addToBasket(product: wishListItems[index].product)
            wishListItems.remove(at: index)
        }
    }
    
    
    static func checkStock(product: Product?) -> Int? {
        guard let product = product else { return nil }

        /// compare basket contents against stock
        guard let stock = product.stock else { return nil }
        if let basketQuantity = items.first(where: { $0.product.productId == product.productId  })?.numberOfItems {
            return stock - basketQuantity
        }
        return stock
    }
    
}


/// Wrapped product to keep track of number of items in the basket. Started as a struct and changed to class as above
class BasketItem: Hashable {
    static func == (lhs: BasketItem, rhs: BasketItem) -> Bool {
        return lhs.hashValue == rhs.hashValue && lhs.product.name == rhs.product.name && lhs.product.productId == rhs.product.productId 
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.name)
        hasher.combine(product.productId)
    }
    
    var numberOfItems: Int = 1
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
}
