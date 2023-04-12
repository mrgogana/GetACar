//
//  ProsConsTableViewCell.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-11.
//

import UIKit

class ProsConsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var proConsTableView: UITableView!
    
    // MARK: - Variables
    var car: Car?

    // MARK: - Methods
    func configCell(car: Car) {
        self.car = car
        self.proConsTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource Methods
extension ProsConsTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let car = self.car else { return 0 }
        var sections = 0
        if !car.prosList.isEmpty {
            sections+=1
        }
        if !car.consList.isEmpty {
            sections+=1
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let car = self.car else { return 0 }
        
        if indexPath.row == 0 {
            return Constants.titleRowHeight
        } else {
            let item = (indexPath.section == 0 && !car.prosList.isEmpty) ?
                                    car.prosList[indexPath.row-1] :
                                    car.consList[indexPath.row-1]
            return item.getHeightOfString()+Constants.itemRowMargin
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let car = self.car else { return 0 }
        let rows = (section == 0  && !car.prosList.isEmpty) ?
                                    car.prosList.count+1 :
                                    car.consList.count+1
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let car = self.car else { return UITableViewCell() }
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTitleTableViewCell.self)) as? ListTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configCell(title: (indexPath.section == 0 && !car.prosList.isEmpty) ? Constants.pros : Constants.cons)
            
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListItemTableViewCell.self)) as? ListItemTableViewCell else {
            return UITableViewCell()
        }
        let item = (indexPath.section == 0 && !car.prosList.isEmpty) ?
                                                    car.prosList[indexPath.row-1] :
                                                    car.consList[indexPath.row-1]
        cell.configCell(item: item)
        
        return cell
    }
}
