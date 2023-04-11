//
//  ListTitleTableViewCell.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-11.
//

import UIKit

class ListTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public Methods
    func configCell(title: String) {
        self.titleLabel.text = title
    }

}
