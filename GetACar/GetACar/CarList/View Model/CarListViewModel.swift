//
//  CarListViewModel.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

class CarListViewModel {
    
    // MARK: - Private Attributes
    let carService: ListServices = JsonFileReader()
    
    // MARK: - Private Attributes
    var sections: [Section] = [Section]()
    
    // MARK: - Public Methods
    func getCars(completion: @escaping([Car]?, NetworkError?)->Void) {
        self.carService.getCarList() { [weak self] result in
            guard let self = self else { return }
            switch (result) {
            case .success(let carList):
                carList.forEach { car in
                    var refinedCar = car
                    refinedCar.prosList = car.prosList.filter{!$0.isEmpty}
                    refinedCar.consList = car.consList.filter{!$0.isEmpty}
                    self.sections.append(Section(car: refinedCar))
                }
                completion(carList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func heightOfList(list: [String]) -> CGFloat {
        var height: CGFloat = Constants.titleRowHeight
        for text in list {
            let textheight = text.getHeightOfString()
            height += textheight+Constants.itemRowMargin
        }
        return height
    }
}


struct Section: Equatable {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.isOpened == rhs.isOpened
    }
    
    let car: Car
    var isOpened: Bool = false
}
