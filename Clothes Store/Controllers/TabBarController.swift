//
//  TabBarController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//
import UIKit
import Combine

class TabBarController: UITabBarController {

    //Views
    var tabItem : UITabBarItem?

    //Variables
    
    var wishListCount = 0
    var basketCount = Basket.calculateTotalItemsInBasket()
    
    private var totalSubscriber: AnyCancellable?
    private var basketViewModel = Basket()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()

        if let tabItems = tabBar.items {
            // In this case we want to modify the badge number of the second tab:
            tabItem = tabItems[1]
            tabItem?.badgeValue = String(wishListCount)
            
            // In this case we want to modify the badge number of the third tab:
            tabItem = tabItems[2]
            tabItem?.badgeValue = String(basketCount)
            
            
            totalSubscriber = basketViewModel.$totalInBasketPublished
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { value in
                    self.tabItem?.badgeValue = value.description
                })
            
        }
        

    }
    
    func loadData() {
        self.basketCount = Basket.calculateTotalItemsInBasket()
    }
}
