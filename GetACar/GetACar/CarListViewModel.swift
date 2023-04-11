//
//  CarListViewModel.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

class CarListViewModel {
    
    let carService: ListServices = JsonFileReader()
    var carList: [Car] = [Car]()
    
    func getCars(completion: @escaping([Car]?, NetworkError?)->Void) {
        self.carService.getCarList() { [weak self] result in
            guard let self = self else { return }
            switch (result) {
            case .success(let carList):
                self.carList = carList
                completion(carList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
