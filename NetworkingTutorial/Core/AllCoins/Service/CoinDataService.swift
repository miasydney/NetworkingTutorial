//
//  CoinDataService.swift
//  NetworkingTutorial
//
//  Created by Mia on 24/7/2024.
//

import Foundation

class CoinDataService {
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

                if let error = error {
                    print("DEBUG: Failed with error \(error.localizedDescription)")
    //                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { // make sure we have response before we go any further
    //                    self.errorMessage = "Bad HTTP Response"
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
    //                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                                
                guard let data = data else { return }
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                print(jsonObject)
                guard let value = jsonObject[coin] as? [String: Double] else {
                    print("Failed to parse value")
                    return
                }
                
                guard let price = value["usd"] else { return }
                
    //                self.coin = coin.capitalized
    //                self.price = "$\(price)"
                print("DEBUG: price in service is \(price)")
                completion(price)
        }.resume()
            
    
        
    }
}
