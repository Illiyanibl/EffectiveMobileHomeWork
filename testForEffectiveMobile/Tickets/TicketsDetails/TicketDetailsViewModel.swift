//
//  TicketDetailViewModel.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import Foundation
protocol TicketsDetailsViewModelOutput {
    var state: DetailsState { get set }
    var currentState: ((DetailsState) -> Void)? { get set }
    func changeStateIfNeeded()
}
enum DetailsState {
    case initial
    case loading
    case loaded([Tickets])
    case error
}

final class TicketDetailsViewModel: TicketsDetailsViewModelOutput {
    private let service: TicketsDetailsModelProtocol = TicketsDetailsModelService()
    var currentState: ((DetailsState ) -> Void)?
    var state: DetailsState = .initial {
        didSet {
            currentState?(state)
        }
    }
    lazy var dateFormatter = {
        //"2024-02-23T15:20:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()

    func changeStateIfNeeded(){
        state = .loading
        service.getOffers(){ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let tickets):
                var mapingTickets = tickets
                timeСalculation(tickets: &mapingTickets)
                state = .loaded(mapingTickets)
            case .failure(_):
                state = .error
                print("Error")
            }
        }
    }

    func timeСalculation( tickets: inout [Tickets]) {
        tickets.enumerated().forEach(){ index, element in
                let departureDate = self.dateFormatter.date(from: element.departure.date)
                let arrivalDate = self.dateFormatter.date(from: element.arrival.date)
                guard let departureDate, let arrivalDate else { return }
                let timeInterval = arrivalDate.timeIntervalSince(departureDate)
                tickets[index].timeInterval =  String(format:"%.1f", timeInterval / 3600)
                tickets[index].departureTime = departureDate
                tickets[index].arrivalTime = arrivalDate
        }
    }
}
