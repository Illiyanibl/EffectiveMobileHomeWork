//
//  TicketsDetailExtension.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
extension TicketDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    TicketDetailsTableViewCell.identifier, for: indexPath) as!  TicketDetailsTableViewCell
        guard indexPath.row < tickets.count else { return cell }
        let ticketsRow = tickets[indexPath.row]
    
       // cell.setupCell(price: ticketsRow.price.value, timeInterval: ticketsRow.timeInterval, hasTransfer: ticketsRow.hasTransfer, )
        cell.setupCell(price: ticketsRow.price.value, timeInterval: ticketsRow.timeInterval, departure: ticketsRow.departureTime, arrival: ticketsRow.arrivalTime, pointFrom: ticketsRow.departure.airport, pointTo: ticketsRow.arrival.airport, hasTransfer: ticketsRow.hasTransfer)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119 // быстрый фикс
    }


}
