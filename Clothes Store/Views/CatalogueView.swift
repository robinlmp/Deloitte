//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI
import UIKit


// I had to do a few hacky things to make this view look OK. This is the first time I've done SwiftUI
// inside a UIKit app. I've used UIKit views inside a SwiftUI app a few times (eg mapkit) but I found
// the SwiftUI view did not play happily inside the UIKit navigation view. I couldn't figure out how
// to turn off the UINavigationView so couldn't use SwiftUI NavigationView. For some reason, the UIKit
// one does not provide a background nor does it scale upon scrolling as it would normally.
// To work around the lack of background, I added my own. But had to live with the Navigation title
// provided by UIKit.
// Unfortunately, there was then a further hitch that I've partially worked around. When displaying
// the product detail view modally from the SwiftUI catalogue view, the view lost it's background.
// I've worked around it by adding a view extension that adds a rectangle behind the view. It works
// OK in light mode but looks really bad in dark mode. Would need more work.

struct CatalogueView: View {
    /// Background colour to match that of UIKit views
    let appBackgroundColour = Color(UIColor.backgroundColour)
    
    /// Setting up griditems for the two column LazyVGrid catalogue view
    let gridItem = [GridItem(), GridItem()]
    
    /// Empty array that is then populated as the `getProducts` function completes
    @State private var productsArray: [Product] = []
    
    
    var body: some View {
        /// ZStack mainly because of the need for dealing with the navigation title / bar problems
            ZStack {
        /// SwiftUI doesn't have a nav bar background by default so added one to match UIKit views
                Rectangle().foregroundColor(appBackgroundColour)
        /// The main catalogue view is a LazyVGrid inside a ScrollView
                ScrollView {
                    LazyVGrid(columns: gridItem, spacing: 35) {
                        ForEach(productsArray, id: \.self) { product in
                            /// See separate child view for individual product cards or cells
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 10)
                }
                
                VStack {
                    ZStack {
                        Rectangle().foregroundColor(appBackgroundColour)
                        /// The height of 143 seems right for iPhone 12 Pro but off for other sizes
                        /// Would need to find a way of extracting the actual nav bar height from UIKit for SwiftUI
                        /// to use. I imagine introspect would do it. Or direct from UIKit. I had a go but haven't worked
                        /// it out as yet.
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
                // Deal with errors here. My experience of erorr handling
                // isn't extensive but I'm aware something should be done
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

