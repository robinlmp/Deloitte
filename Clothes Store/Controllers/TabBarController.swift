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
    
    /// I've tried and failed to get Combine working to update the badge numbers on the tab bar icons.
    /// I've just had to accept that task 6 is not complete. I've done the easy bit of getting the badges
    /// to show. The hard bit of getting the numbers to update I have not done.
    var wishListCount = 0
    var basketCount = Basket.calculateTotalItemsInBasket()
    
    /// this is a remnant of trying to get Combine working
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
            /// In this case we want to modify the badge number of the second tab:
            tabItem = tabItems[1]
            tabItem?.badgeValue = String(wishListCount)
            
            /// In this case we want to modify the badge number of the third tab:
            tabItem = tabItems[2]
            tabItem?.badgeValue = String(basketCount)
            
            /// Another remnant of my Combine efforts
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
