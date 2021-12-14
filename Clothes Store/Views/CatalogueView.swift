//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI


// I had to do a few hacky things to make this view look OK. This is the first time I've done SwiftUI
// inside a UIKit app. I've used UIKit views inside a SwiftUI app a few times (eg mapkit) but I found
// the SwiftUI view did not play happily inside the UIKit navigation view. I couldn't figure out how
// to turn off the UINavigationView so couldn't use SwiftUI NavigationView. For some reason, the UIKit
// one does not provide a background nor does it scale upon scrolling as it would normally.
// To work around the lack of background, I added my own. But had to live with the Navigation title
// provided by UIKit.
// Unfortunately, there was then a further hitch that I've not been able to work around yet which is
// that when navigating back to UIKit product detail view displayed modally, for some reason this view
// has no background despite various attempts to set one. Probably if my UIKit skills were better I
// would have added one quickly enough.

struct CatalogueView: View {
    /// Background colour to match that of
    let appBackgroundColour = Color(UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1))
    
    /// Setting up griditems for the two column LazyVGrid catalogue view
    let gridItem = [GridItem(), GridItem()]
    
    @State private var productsArray: [Product] = []
    
    var body: some View {

            ZStack {
                Rectangle().foregroundColor(appBackgroundColour)
        
                ScrollView {
                    LazyVGrid(columns: gridItem, spacing: 35) {
                        ForEach(productsArray, id: \.self) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 10)
                }
                
                VStack {
                    ZStack {
                        Rectangle().foregroundColor(appBackgroundColour)
                    }.frame(height: 143)
                    Spacer()
                }.ignoresSafeArea()
            }
            .onAppear {
                do {
                    try getProducts()
                } catch {
                    print(error.localizedDescription)
                }
                
            }
    }
    
    
    
    
    func getProducts() throws {
        DataService.getProducts { (products, error) in
            if error != nil{
                // Really should deal with errors here
                
            } else {
                self.productsArray = products?.products ?? []
            }
        }
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}

