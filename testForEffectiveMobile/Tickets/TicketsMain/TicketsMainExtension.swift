//
//  TicketsViewControllerExtension..swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 30.05.24.
//

import UIKit
extension TicketsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate {
    private var allowedCharacters: String { return "ЙйЦцКкУуЕеНнГгШшЩщЗзХхъФфЫыВвАаПпРрОоЛлДдЖжЭэЁёЯяЧчСсМмИиТтьБбЮю-"}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       // if textField == findArrived { self.mainAction?(.selectedDepatrure(findDeparture.text ?? ""))}
        //вместо UITapGestureRecognizer
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" { return true }
        if allowedCharacters.contains(string)  { return true } else { return false }
    }

    private var inset: CGFloat  { return 0}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: 214)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 111 //в макете одна ячейка 244 ширины другая 132, принял что 111 разницы это отступ одной ячейки от другой
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        offers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketsCollectionViewCell.identifier, for: indexPath) as! TicketsCollectionViewCell
        cell.setupCell(imageName: offers[indexPath.row].image,
                       cityName: offers[indexPath.row].town,
                       title: offers[indexPath.row].title)
        return cell
    }

}

