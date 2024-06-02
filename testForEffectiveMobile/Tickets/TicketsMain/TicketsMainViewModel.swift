//
//  TicketsMainVM.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 31.05.24.
//

import Foundation
protocol TicketsViewModelOutput {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    func changeStateIfNeeded()
}
enum State {
    case initial
    case loading
    case loaded([Offers])
    case error
}

final class TicketsMainViewModel: TicketsViewModelOutput{
    private let service: TicketsMainServiceProtocol = TicketsMainService()
    var currentState: ((State) -> Void)?
    var state: State = .initial {
        didSet {
            currentState?(state)
        }
    }

    func changeStateIfNeeded(){
        state = .loading
        service.getOffers(){ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let offers):
                state = .loaded(offers)
            case .failure(_):
                state = .error
            }
        }
    }

}
