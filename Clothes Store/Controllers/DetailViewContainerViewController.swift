//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class DetailViewContainerViewController: UIViewController {
    

    //Views
    var backButton : UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    //Variables
    var product : Product!
    var stock: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stock = Basket.checkStock(product: product)

        setUpButtons()
        setUpLabels()
    }
    
    
    func setUpLabels() {
        addedToBasketLabel.isHidden = true
        addedToWishlistLabel.isHidden = true
    }
    
    func setUpButtons(){
        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        
        if stock == 0 {
            addToCartButton.dropShadow(radius: 0, opacity: 0, color: UIColor.primaryColour)
            addToCartButton.backgroundColor = UIColor.quaternaryLabel
            addToCartButton.isEnabled = false
        } else {
            addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NavStrings.detailContainer.rawValue {
            let dest = segue.destination as! ProductDetailTableViewController
            dest.product = product
        }
    }


    // MARK: - Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addToCartAction(_ sender: Any) {
        Haptic.feedBack()
        
        addToCartButton.buttonPress(label: addedToBasketLabel, pressedColour: .pressedColour)
        
        Basket.addToBasket(product: product)
        
        stock = Basket.checkStock(product: product)
        
        print(Basket.items.count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.setUpButtons()
        }
    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        
        Basket.addToWishList(product: product)
        
        wishListButton.buttonPress(label: addedToWishlistLabel, pressedColour: .pressedColourForWhite)
    }
}
