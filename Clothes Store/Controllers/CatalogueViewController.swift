//
//  CatalogueViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit
import SwiftUI

class CatalogueViewController: UIViewController {

    //Views
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    
    func addSwiftUIView() {
        let swiftUIView = CatalogueView()
        let hostingController = UIHostingController(rootView: swiftUIView)

        /// Add as a child of the current view controller.
        addChild(hostingController)

        /// Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(hostingController.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        /// Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }
    
    

    //Variables
    var products : [Product] = []
    
//    let swiftUIVC = UIHostingController(rootView: CatalogueView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwiftUIView()

        getProducts()
    }

    func getProducts(){

        DataService.getProducts { (products, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "There has been an error getting the data. Please check your network connection and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.getProducts()
                    alert.dismiss(animated: true, completion: nil)
                }))

                self.present(alert, animated: true, completion: nil)
            } else {

                self.products = products?.products ?? []
                self.activity.isHidden = true
                self.collectionView.reloadData()
            }
        }
    }
}

extension CatalogueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! CatalogueViewCollectionViewCell
        
        let product = products[indexPath.row]
        cell.configureWithProduct(product: product)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let product = products[indexPath.row]

        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailContainer") as? DetailViewContainerViewController else { return }
        let navigationVC = UINavigationController(rootViewController: detailVC)
        detailVC.product = product
        Haptic.feedBack()
        self.present(navigationVC, animated: true, completion: nil)
    }

}

