//
//  CarListViewControler.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import UIKit

class CarListViewControler: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let viewModel: CarListViewModel = CarListViewModel()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = Constants.appTitle
        
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
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
}

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
