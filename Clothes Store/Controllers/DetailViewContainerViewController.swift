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
        if segue.identifier == "detailContainer" {
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
        
        buttonPress(button: addToCartButton, label: addedToBasketLabel, pressedColour: .pressedColour)
    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        
        buttonPress(button: wishListButton, label: addedToWishlistLabel, pressedColour: .pressedColourForWhite)
    }
        
    func buttonPress(button: UIButton, label: UILabel, pressedColour: UIColor) {
        
        guard let buttonBackground = button.backgroundColor else { return }
        guard let shadowColourCG = button.layer.shadowColor else { return }
        let shadowColour = UIColor(cgColor: shadowColourCG)
        let shadowOpacity = button.layer.shadowOpacity

        button.dropShadow(radius: 0, opacity: 0, color: .clear)
        button.backgroundColor = pressedColour
        label.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            button.dropShadow(radius: 8, opacity: shadowOpacity, color: shadowColour)
            button.backgroundColor = buttonBackground
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                label.isHidden = true
                
            }
        }
    }
}
