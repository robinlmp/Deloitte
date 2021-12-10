//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class DetailViewContainerViewController: UIViewController{


    //Views
    var backButton : UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    //Variables
    var product : Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtons()
        setUpLabels()
    }
    
    func setUpLabels() {
        addedToBasketLabel.isHidden = true
        addedToWishlistLabel.isHidden = true
    }
    
    func setUpButtons(){
        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailContainer"{
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
        
        addToCartButton.dropShadow(radius: 0, opacity: 0, color: .clear)
        addToCartButton.backgroundColor = UIColor.pressedColour
        addedToBasketLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
            self.addToCartButton.backgroundColor = UIColor.primaryColour
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.addedToBasketLabel.isHidden = true
            }
        }
        
        
        
        
    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        
        wishListButton.dropShadow(radius: 0, opacity: 0, color: .clear)
        wishListButton.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        addedToWishlistLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
            self.wishListButton.backgroundColor = UIColor.white
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.addedToWishlistLabel.isHidden = true
            }
        }

    }
}
