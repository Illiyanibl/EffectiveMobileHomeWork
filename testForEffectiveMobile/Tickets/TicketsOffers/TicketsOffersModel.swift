//
//  TicketsOffersModel.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
protocol TicketsOffersModelProtocol: AnyObject  {
    func getOffers(completion: @escaping (Result<[TicketsOffers], Error>) -> Void)
}

final class TicketsOffersModelService: TicketsOffersModelProtocol {
    func getOffers(completion: @escaping (Result<[TicketsOffers], Error>) -> Void){
        let urlString = "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017"
        NetworkService.requestURL(for: urlString){ result in
            switch result {
            case .success(let data):
                let ticketsOffers = DeserializationService.ticketsOffersDecoder(data: data)
                completion(.success(ticketsOffers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct TicketsOffersModel: Decodable {
    var ticketsOffers: [TicketsOffers]
}

struct TicketsOffers: Decodable {
    var id: Int
    var title: String
    var timeRange: [String]
    var price: TicketPrice
}
struct TicketPrice: Decodable {
    var value: Int
}

