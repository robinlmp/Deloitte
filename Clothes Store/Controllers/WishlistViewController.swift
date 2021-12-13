//
//  WishlistViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


protocol BuyCellButtonTapped: AnyObject {
    func addProductToBasket(_ sender: SavedViewTableViewCell)
}

class WishlistViewController: UIViewController, BuyCellButtonTapped, UITableViewDataSource {

    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!

    //Variables
    var productsArray: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        productsArray = Basket.wishListItems.map( { $0.product } )
        
        noProductsLabel.isHidden = productsArray.isEmpty ? false : true

        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell") as? SavedViewTableViewCell
        {
            cell.configureWithProduct(basketItem: Basket.wishListItems[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }

    // MARK: - Actions
    func addProductToBasket(_ sender: SavedViewTableViewCell) {
        Haptic.feedBack()
        
    }
}

extension WishlistViewController: UITableViewDelegate{
    
    override func viewWillAppear(_ animated: Bool) {
        productsArray = Basket.wishListItems.map( { $0.product } )
        noProductsLabel.isHidden = productsArray.isEmpty ? false : true

        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title: "Remove", handler: { (action, view, completion) in
            
            Haptic.feedBack()
          
        })

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config

    }
}


