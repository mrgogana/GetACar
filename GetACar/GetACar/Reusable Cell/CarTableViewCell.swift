//
//  CarTableViewCell.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var carPriceLbl: UILabel!
    @IBOutlet weak var carTitleLbl: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!

    // MARK: - Methods
    func configCell(car: Car) {
        self.carTitleLbl.text = car.make+" "+car.model
        self.carImageView.image = UIImage(named: car.carImageName())
        self.carPriceLbl.text = String.priceString(price: car.customerPrice)
        showRating(rating: car.rating)
    }
    
    // MARK: - Private Methods
    fileprivate func showRating(rating: Int) {
        for (_, value) in ratingView.subviews.enumerated() {
            value.isHidden = (value.tag > rating)
        }
    }

}
