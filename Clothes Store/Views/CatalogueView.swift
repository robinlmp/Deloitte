//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI


//Create a UIHostingController class that hosts your SwiftUI view
//class SwiftUIViewHostingController: UIHostingController<CatalogueView> {
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder, rootView: CatalogueView())
//    }
//}



struct CatalogueView: View {
    let appBackgroundColour = Color(UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1))
    let appBackgroundColour2 = Color(UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 0.9))
    
    let gridItem = [GridItem(), GridItem()]
    
    @State private var productsArray: [Product] = []
    
    var body: some View {

            ZStack {
                Rectangle().foregroundColor(appBackgroundColour)
                
//                ScrollView {
//                    ForEach(productsArray, id: \.self) { product in
//                        ProductCardView(product: product)
//                    }
//                    .frame(maxWidth: .infinity)
//                }
                
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
                getProducts()
            }
    }
    
    
    
    
    func getProducts(){
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

//struct ProductCardView: View {
//    let customGrey = Color(uiColor: UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1))
//    let product: Product
//    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .foregroundColor(.white)
//            VStack(spacing: 0) {
//                AsyncImage(url: URL(string: product.image ?? "www.apple.com") ) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                } placeholder: {
//                    Image("photo.placeholder")
//                }
//                .padding(8)
//                .padding(.top, 2)
//                
//                HStack {
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text(product.name ?? "")
//                            .font(.footnote)
//                            .fontWeight(.thin)
//                            .foregroundColor(customGrey)
//                            
//                        Text(CurrencyHelper.getMoneyString(product.price ?? 0.0))
//                            .fontWeight(.bold)
//                            .foregroundColor(customGrey)
//                            .padding(.top, 15)
//                            
//                    }
//                    Spacer()
//                }.padding(7)
//            }
//        }
//        .frame(maxWidth: 150, maxHeight: 220)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .shadow(color: .gray.opacity(0.3), radius: 15, x: 0, y: 0)
//    }
//}
