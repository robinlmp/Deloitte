//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


class BasketViewController: UITableViewController, UITableViewDataSource {
    
    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    
    //Variables
    var productsArray: [Product] = Basket.items.map( { $0.product } )

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if Basket.items.count == 0 {
//            tableView.isHidden = true
//            noProductsLabel.isHidden = false
//        } else {
//            tableView.isHidden = false
//            noProductsLabel.isHidden = true
//        }
        
        tableView.dataSource = self
        tableView.delegate = self
        

        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
        
        
        
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
            cell.configureWithProduct(product: productsArray[indexPath.row])
            
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

            Haptic.feedBack()
        })

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config

    }
    

}


