//
//  DataService.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation


// Replaced Alamofire with native URLSession code. 

class DataService {
    
    class func getProducts(completion: @escaping (Products?, Error?) -> Void) {
        
        var products = Products()

        guard let url = URL(string: URLCall.catalogue.rawValue) else {
            print("URL is not valid")
            return
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        

        URLSession.shared.dataTask(with: url) { jsonData, response, error in
            if let data = jsonData {
                if let decodedResponse = try? decoder.decode(Products.self, from: data) {
                    // data received so use main thread to update products
                    DispatchQueue.main.async {
                        products.products = decodedResponse.products
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(products, error)
            }
            
// So easy to foroget to call resume!
        }.resume()
    }
}
