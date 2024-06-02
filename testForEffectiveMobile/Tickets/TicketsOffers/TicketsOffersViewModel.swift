//
//  TicketsOffersViewModel.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

protocol TicketsOffersViewModelOutput {
    var state: OffersState  { get set }
    var currentState: ((OffersState) -> Void)? { get set }
    func changeStateIfNeeded()
}
enum OffersState {
    case initial
    case loading
    case loaded([TicketsOffers])
    case error
}

final class TicketsOffersViewModel: TicketsOffersViewModelOutput{
    private let service: TicketsOffersModelProtocol  = TicketsOffersModelService()
    var currentState: ((OffersState ) -> Void)?
    var state: OffersState  = .initial {
        didSet {
            currentState?(state)
        }
    }

    func changeStateIfNeeded(){
        state = .loading
        service.getOffers(){ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let ticketsOffers):
                state = .loaded(ticketsOffers)
            case .failure(_):
                state = .error
            }
        }
    }

}
