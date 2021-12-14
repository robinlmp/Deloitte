//
//  ProductCardView.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

// Child view for each product cell or card on catalogue view. I'm fairly happy with how
// close I got this looking. I didn't add Helvetica Neue to the project because I don't
// know if I would need a specific licence to do that. But it looks pretty close using
// San Francisco. I spent a fair amount of time tweaking padding, shadow radius, LazyVGrid
// spacing etc.

struct ProductCardView: View {
    /// state to control whether the modal sheet is showing for product details
    @State private var sheetShowing = false
    
    /// should probably add this to global constants. This is a grey for the text to closely match that of the example.
    let customGrey = Color(uiColor: UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1))
    let product: Product
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                
            VStack(spacing: 0) {
                /// Once I found out I was allowed to change the target iOS version I was umming and arring between
                /// targetting iOS 14 and 15. I implemented the main URLSession fetch requests when I was working on
                /// it as iOS12 and saw no need to change it, but being able to use  AsyncImage eventually made my
                /// mind up. Obviously limits backwards compatability and could be replaced with older approaches.
                AsyncImage(url: URL(string: product.image ?? "") ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("photo.placeholder")
                        .resizable()
                        .scaledToFit()
                }
                .padding(8)
                .padding(.top, 2)
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(product.name ?? "")
                            .font(.footnote)
                            .fontWeight(.thin)
                            .foregroundColor(customGrey)
                            
                        Text(CurrencyHelper.getMoneyString(product.price ?? 0.0))
                            .fontWeight(.bold)
                            .foregroundColor(customGrey)
                            .padding(.top, 15)
                            
                    }
                    Spacer()
                }.padding(7)
            }
            
            .sheet(isPresented: $sheetShowing) {
                
            } content: {
                /// Displays UIKit product detail view
                DetailViewController(product: product)
            }

        }
        .onTapGesture {
            sheetShowing = true
        }
        .frame(maxWidth: 150, maxHeight: 220)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray.opacity(0.3), radius: 15, x: 0, y: 0)
        
    }
}
