//
//  ListTitleTableViewCell.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-11.
//

import UIKit

class ListTitleTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Methods
    func configCell(title: String) {
        self.titleLabel.text = title
    }

}
