//
//  ListItemTableViewCell.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-11.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public Methods
    func configCell(item: String) {
        itemLabel.text = item
    }

}
