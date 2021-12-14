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
    
    @State private var productsArray: [Product] = []
    
    var body: some View {

            ZStack {
                Rectangle().foregroundColor(appBackgroundColour)
                
                ScrollView {
                    ForEach(productsArray, id: \.self) { product in
                        ProductCardView(product: product)
                    }
                    .frame(maxWidth: .infinity)
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

struct ProductCardView: View {
    let product: Product
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .foregroundColor(.white)
            .frame(minWidth: 150, minHeight: 220)
            .padding()
            .shadow(color: .gray.opacity(0.3), radius: 15, x: 0, y: 0)
    }
}
