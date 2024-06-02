//
//  TicketsMainModel.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 31.05.24.
//

import Foundation

protocol TicketsMainServiceProtocol: AnyObject  {
    func getOffers(completion: @escaping (Result<[Offers], Error>) -> Void)
}

final class TicketsMainService: TicketsMainServiceProtocol {
    func getOffers(completion: @escaping (Result<[Offers], Error>) -> Void){
        let urlString = "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd"
        NetworkService.requestURL(for: urlString){ result in
            switch result {
            case .success(let data):
                var offers = DeserializationService.ticketsMainDecoder(data: data)
                offers.enumerated().forEach() {index, element in
                    offers[index].image = "collection\(index)"
                }
                completion(.success(offers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct TicketsMainModel: Decodable {
    var offers: [Offers]
}

struct Offers: Decodable {
    var id: Int
    var title: String
    var image: String?
    var town: String
    var price: Price

}
struct Price: Decodable {
    var value: Int
}
