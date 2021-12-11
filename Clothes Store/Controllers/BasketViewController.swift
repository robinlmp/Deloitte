//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


class BasketViewController: UIViewController, UITableViewDataSource {
    
    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    
    //Variables
    var productsArray: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        productsArray = Basket.items.map( { $0.product } )

        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
        
        total.text = "$" + String(format: "%.2f", Basket.items.map( { $0.product.price ?? 0 } ).reduce(Float(0), +))
        
        print(Basket.items.description)

    }
    
    
    // MARK: - Actions
    
    @IBAction func checkoutButton(_ sender: Any) {
        
        checkoutButton.buttonPress(pressedColour: .pressedColour)
    }
    
    
    
    // MARK: - Navigation


    
}

extension BasketViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell") as? BasketViewTableViewCell
        {
            cell.configureWithProduct(product: Basket.items[indexPath.row].product)
            
            return cell
        }
        
        return UITableViewCell()
    }
    

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction.init(style:.destructive, title: "Remove", handler: { (action, view, completion) in
            
            self.productsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            Haptic.feedBack()
        })
        
        deleteAction.backgroundColor = UIColor.primaryColour
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
        
    }

    
}


