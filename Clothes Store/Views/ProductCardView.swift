//
//  ProductCardView.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

struct ProductCardView: View {
    @State private var sheetShowing = false
    
    let customGrey = Color(uiColor: UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1))
    let product: Product
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: product.image ?? "www.apple.com") ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("photo.placeholder")
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
            .onTapGesture {
                sheetShowing = true
            }
            .sheet(isPresented: $sheetShowing) {
                
            } content: {
                DetailViewController(product: product)
            }

        }
        .frame(maxWidth: 150, maxHeight: 220)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray.opacity(0.3), radius: 15, x: 0, y: 0)
        
    }
}

//struct ProductCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCardView()
//    }
//}
