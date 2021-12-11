//
//  DataService.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation

class DataService {
    
    class func getProducts(completion: @escaping (Products?, Error?) -> Void) {
        
        var products = Products()

        guard let url = URL(string: URLCall.catalogue.rawValue) else {
            print("URL is not valid")
            return
        }

        let request = URLRequest(url: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        URLSession.shared.dataTask(with: request) { jsonData, response, error in
            if let data = jsonData {
                if let decodedResponse = try? decoder.decode(Products.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        products.products = decodedResponse.products
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(products, error)
            }
            
        }.resume()
        
    }
}
