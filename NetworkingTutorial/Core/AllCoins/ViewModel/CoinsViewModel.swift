//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Mia on 23/7/2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coin = ""
    @Published var price = ""
    
    init() {
        fetchPrice(coin: "ethereum")
        fetchPrice(coin: "litecoin")
    }
    
    func fetchPrice(coin: String) {
        print(Thread.current)
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        print("Fetching price...") // 1
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(Thread.current)
            print("Did receive data: \(data)") // 2
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            print(jsonObject)
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return
            }
            
            guard let price = value["usd"] else { return }
            
            DispatchQueue.main.async {
                print(Thread.current)
                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
            
        }.resume()
        
        print("Did reach end of function..") // 3
    }
}
