//
//  SavedViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class SavedViewTableViewCell: UITableViewCell{

    //Views
    @IBOutlet var cellView: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var addToButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    //Variables
    weak var delegate : BuyCellButtonTapped?

    func configureWithProduct(basketItem: BasketItem){
        let product = basketItem.product
        
        self.productName.text = product.name
        self.productPrice.text = CurrencyHelper.getMoneyString(product.price ?? 0)
        self.cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)
        
        let placeHolderImage = UIImage(imageTitle: .placeHolder)
        
        if let imageURL = URL(string: product.image ?? "") {
            productImage.load(url: imageURL)
        } else {
            productImage.image = placeHolderImage
        }
    }

    @IBAction func addToBasket(_ sender: Any) {
        delegate?.addProductToBasket(self)
        
        addToButton.buttonPress(pressedColour: UIColor.white)
        
        /// Using the product name to identify the product is not ideal. This is a further consequence of my problems
        /// sharing data between VCs. In the context of this IBAction func, there no BasketItem or Product, just a
        /// product name. Very aware that I've not done this correctly but it kind of works and would like to learn.
        Basket.moveToBasketFromWishlist(basketItem: Basket.wishListItems.first(where: { $0.product.name == productName.text }))
        
    }


}
