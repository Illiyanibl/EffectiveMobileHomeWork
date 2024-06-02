//
//  TicketsModalModel.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 1.06.24.
//

import Foundation
protocol TicketsModalModelProtocol{
    func getModel() -> [TicketsModalModel]
}
struct TicketsModalservice: TicketsModalModelProtocol {
    func getModel() -> [TicketsModalModel] {
        var model: [TicketsModalModel] = []
        let description = "Популярное направление"
        model.append(TicketsModalModel(city: "Стамбул", image: "istambul", description: description))
        model.append(TicketsModalModel(city: "Сочи", image: "sochi", description: description))
        model.append(TicketsModalModel(city: "Пхукет", image: "phuket", description: description))
        return model
    }
}
struct TicketsModalModel {
    var city: String
    var image: String
    var description: String
}
