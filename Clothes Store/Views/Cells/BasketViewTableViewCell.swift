//
//  BasketViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class BasketViewTableViewCell: UITableViewCell{

    //Views
    @IBOutlet var cellView: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    //Variables
    weak var delegate : BuyCellButtonTapped?

    func configureWithProduct(basketItem: BasketItem){
        
        let product = basketItem.product
        let quantity = basketItem.numberOfItems

        self.productName?.text = product.name
        self.productPrice?.text = CurrencyHelper.getMoneyString(product.price ?? 0)
        self.cellView?.dropShadow(radius: 10, opacity: 0.1, color: .black)
        self.quantity?.text = "Qty: \(quantity)"
        let placeHolderImage = UIImage(imageTitle: .placeHolder)
        
        if let imageURL = URL(string: product.image ?? "") {
            productImage.load(url: imageURL)
        } else {
            productImage.image = placeHolderImage
        }

    }
}

