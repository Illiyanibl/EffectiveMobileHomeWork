//
//  TicketDetailsModel.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import Foundation
protocol TicketsDetailsModelProtocol: AnyObject  {
    func getOffers(completion: @escaping (Result<[Tickets], Error>) -> Void)
}

final class TicketsDetailsModelService: TicketsDetailsModelProtocol {
    func getOffers(completion: @escaping (Result<[Tickets], Error>) -> Void){
        let urlString = "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf"
        NetworkService.requestURL(for: urlString){ result in
            switch result {
            case .success(let data):
                let tickets = DeserializationService.ticketsDetailsDecoder(data: data)
                completion(.success(tickets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct TicketsDetailModel: Decodable {
    var tickets: [Tickets]
}

struct Tickets: Decodable {
    var id: Int
    var bage: String?
    var price: TicketDetailPrice
    var providerName: String
    var company: String
    var departure: City
    var arrival: City
    var hasTransfer: Bool
    var departureTime: Date?
    var arrivalTime: Date?
    var timeInterval: String?
}

struct City: Decodable {
    var date: String
    var airport: String
}

struct TicketDetailPrice: Decodable {
    var value: Int
}


