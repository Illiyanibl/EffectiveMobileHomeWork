//
//  DeserializationService.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 31.05.24.
//

import Foundation
struct DeserializationService {
    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static func ticketsMainDecoder(data: Data) -> [Offers] {
        let ticketsMainModel =  try? self.decoder.decode(TicketsMainModel.self, from: data)
        return ticketsMainModel?.offers ?? []
    }

    static func ticketsOffersDecoder(data: Data) -> [TicketsOffers] {
        let ticketsOffersModel = try? self.decoder.decode(TicketsOffersModel.self, from: data)
        return ticketsOffersModel?.ticketsOffers ?? []
    }
    static func ticketsDetailsDecoder(data: Data) -> [Tickets] {
        let ticketsDetailModel = try? self.decoder.decode(TicketsDetailModel.self, from: data)
        return ticketsDetailModel?.tickets ?? []
    }
}
