//
//  TicketsOffersExtension.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
extension TicketsOffersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = TicketsOffersTableHeader()
            return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ticketsOffers.count < 3 ? ticketsOffers.count : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    TicketsOffersTableViewCell.identifier, for: indexPath) as!  TicketsOffersTableViewCell
        guard indexPath.row < ticketsOffers.count else { return cell }
        let ticketsOffersRow = ticketsOffers[indexPath.row]
        cell.setupCell(id: ticketsOffersRow.id, title: ticketsOffersRow.title, price: ticketsOffersRow.price.value, timeRange: ticketsOffersRow.timeRange)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56 // быстрый фикс не успеваю разобратся с auto layout
    }


}
