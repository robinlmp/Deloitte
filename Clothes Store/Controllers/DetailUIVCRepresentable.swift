//
//  DetailUIVCRepresentable.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct DetailViewController: UIViewControllerRepresentable {
    let product: Product

    func makeUIViewController(context: Context) -> DetailViewContainerViewController {
        let detailVC = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "detailContainer") as! DetailViewContainerViewController
        detailVC.product = product
        /// This is the background that was added via the extension to help with consistency of presentation when displayed from a SwiftUI view
        detailVC.view.addBackground()
        return detailVC
    }
    
    func updateUIViewController(_ uiViewController: DetailViewContainerViewController, context: Context) { }
    
}
