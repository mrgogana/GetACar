//
//  ListItemTableViewCell.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-11.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var itemLabel: UILabel!
    
    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Methods
    func configCell(item: String) {
        itemLabel.text = item
    }

}
