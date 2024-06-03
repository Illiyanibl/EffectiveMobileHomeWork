//
//  TicketsOffersButtonCell.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
final class TicketsOffersButtonCell: UICollectionViewCell {

    private let titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        return label
    }()

    lazy var buttonIcon: UIView = {
        let view = UIView()
        let backgraung = UIImage(named: "airplane1")
        guard let backgraung else { return view}
        view.layer.contents = backgraung.cgImage
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
      //  setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSubView(){
        contentView.backgroundColor = UIColor(hex: "#2F3035")
        contentView.layer.cornerRadius = 12 //50?
        contentView.addSubviews([titleLabel, buttonIcon])
    }

    func setupCell(imageName: String?, title: String) {
        //let image = UIImage(named: imageName ?? "")
        //guard let image else { return}

    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([

        ])
    }

}
extension TicketsOffersButtonCell: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}
