//
//  CatalogueView.swift
//  Clothes Store
//
//  Created by Robin Phillips on 14/12/2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI


//Create a UIHostingController class that hosts your SwiftUI view
class SwiftUIViewHostingController: UIHostingController<CatalogueView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: CatalogueView())
    }
}



struct CatalogueView: View {
    var body: some View {
        ScrollView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("Catalogue")
        }
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
