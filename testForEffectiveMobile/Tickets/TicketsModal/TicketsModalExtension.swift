//
//  TicketsModalExtension.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 1.06.24.
//

import UIKit
extension TicketsModalViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    private var allowedCharacters: String { return "ЙйЦцКкУуЕеНнГгШшЩщЗзХхъФфЫыВвАаПпРрОоЛлДдЖжЭэЁёЯяЧчСсМмИиТтьБбЮю-"}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == findArrived {
            findDeparture.text == "" ? findDeparture.text = "Москва" : ()
            findArrived.text == "" ? findArrived.text = "Стамбул" : ()
            self.modalAction?(.selectedDirection(findDeparture.text ?? "Москва", findArrived.text ?? "Стамбул"))
            dismiss(animated: true)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" { return true }
        if allowedCharacters.contains(string)  { return true } else { return false }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    TicketsTableViewCell.identifier, for: indexPath) as!  TicketsTableViewCell
        guard indexPath.row < popularPlaces.count else { return cell }
        let popularPlacesRow = popularPlaces[indexPath.row]
        cell.setupCell(city: popularPlacesRow.city, image: popularPlacesRow.image, description: popularPlacesRow.description)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = popularPlaces[indexPath.row].city
        setupArrived(city)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }


    

}
