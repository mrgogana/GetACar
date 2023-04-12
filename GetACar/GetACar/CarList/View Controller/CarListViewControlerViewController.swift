//
//  CarListViewControler.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import UIKit

class CarListViewControler: UIViewController {
    
    // MARK: - IBOutlets Attributes
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var carMakeButton: UIButton!
    @IBOutlet weak var carModelButton: UIButton!
    
    // MARK: - Constants
    let viewModel: CarListViewModel = CarListViewModel()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = Constants.appTitle
        
        self.tableView.separatorStyle = .none
        
        self.carMakeButton.setTitle(Constants.anyMake, for: .normal)
        self.carModelButton.setTitle(Constants.anyModel, for: .normal)
        
        self.viewModel.getCars { [weak self] _, error in
            guard let self = self else { return }
            
            guard let networkError = error else {
                self.tableView.reloadData()
                return
            }
            self.showErrorAlert(message: networkError.errorMsg())
        }
    }
    
    // MARK: - Private Methods
    fileprivate func showErrorAlert(message: String) {
        let alertViewController = UIAlertController(title: Constants.errorTitle, message: message, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: Constants.okay, style: .cancel)
        alertViewController.addAction(actionAlert)
        self.present(alertViewController, animated: true)
    }
    
    fileprivate func showActionSheet(type: FilterType, list: [String]) {
        let actionSheet = UIAlertController(title: type.rawValue,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        for item in list {
            let action = UIAlertAction(title: item, style: .default) { [weak self] action in
                guard let self = self else { return }
                self.applyFilter(for: type, title: action.title)
                self.tableView.reloadData()
            }
            actionSheet.addAction(action)
        }
        let actionAny = UIAlertAction(title: "Any", style: .default) { [weak self] action in
            guard let self = self else { return }
            self.applyFilter(for: type)
            self.tableView.reloadData()
        }
        actionSheet.addAction(actionAny)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        actionSheet.addAction(actionCancel)
        present(actionSheet, animated: true)
    }
    
    fileprivate func applyFilter(for type: FilterType, title: String? = nil) {
        self.viewModel.setFilter(for: type, selectedTitle: title)
        if type == .make {
            self.carMakeButton.setTitle(title ?? Constants.anyModel, for: .normal)
            self.carModelButton.setTitle(Constants.anyModel, for: .normal)
        } else {
            self.carModelButton.setTitle(title ?? Constants.anyModel, for: .normal)
        }
    }
    
    // MARK: - IBAction Methods
    @IBAction func tapOnCarMake(_ sender: Any) {
        let list = viewModel.getFiltersData(for: .make)
        self.showActionSheet(type: .make, list: list)
    }
    
    @IBAction func tapOnCarModel(_ sender: Any) {
        let list = viewModel.getFiltersData(for: .model)
        self.showActionSheet(type: .model, list: list)
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource Methods
extension CarListViewControler: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        return section.isOpened ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            let car = viewModel.sections[indexPath.section].car
            var height: CGFloat = 0.0
            if !car.prosList.isEmpty {
                height += viewModel.heightOfList(list: car.prosList)
            }
            if !car.consList.isEmpty {
                height += viewModel.heightOfList(list: car.consList)
            }
            return height
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        sectionFooterView.backgroundColor = .white
        let lineView = UIView(frame: CGRect(x:20,y:13 ,width:sectionFooterView.frame.width-40,height:4))
        lineView.backgroundColor = UIColor(named: Constants.orangeColor)
        sectionFooterView.addSubview(lineView)
        return sectionFooterView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarTableViewCell.self)) as? CarTableViewCell else {
                return UITableViewCell()
            }
            cell.configCell(car: viewModel.sections[indexPath.section].car)
            
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProsConsTableViewCell.self)) as? ProsConsTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(car: viewModel.sections[indexPath.section].car)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: false)
            var reloadSet = [Int]()
            if var openedSection = viewModel.sections.filter({$0.isOpened}).first,
               let openIndex = viewModel.sections.firstIndex(where: {$0 == openedSection}),
               openIndex != indexPath.section {
                openedSection.isOpened = !openedSection.isOpened
                viewModel.sections[openIndex] = openedSection
                reloadSet.append(openIndex)
            }
            viewModel.sections[indexPath.section].isOpened.toggle()
            reloadSet.append(indexPath.section)
            tableView.reloadSections(IndexSet(reloadSet), with: .automatic)
        }
    }
}
