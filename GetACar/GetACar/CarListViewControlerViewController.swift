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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.navigationController?.navigationBar.topItem?.title = "Guidomia"

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
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel)
        alertViewController.addAction(actionAlert)
        self.present(alertViewController, animated: true)
    }
}

extension CarListViewControler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarTableViewCell.self)) as? CarTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(car: viewModel.carList[indexPath.row])
        
        return cell
    }
    
    
}
