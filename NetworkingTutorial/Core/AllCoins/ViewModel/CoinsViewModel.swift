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
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
    
    init() {
        fetchPrice(coin: "bitcoin")
    }
    
    func fetchPrice(coin: String) {
        service.fetchPrice(coin: coin) { priceFromService in
            print("DEBUG: Price from service is \(priceFromService)")
            DispatchQueue.main.async {
                self.price = "$\(priceFromService)"
                self.coin = coin
            }
        }
    }
}
