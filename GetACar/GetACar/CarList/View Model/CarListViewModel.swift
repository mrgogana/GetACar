//
//  CarListViewModel.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

class CarListViewModel {
    
    // MARK: - Constants
    let carService: ListServices = JsonFileReader()
    
    // MARK: - Variables
    var sections: [Section] = [Section]()
    var originalSections: [Section] = [Section]()
    var selectedMake: String?
    var selectedModel: String?
    
    // MARK: - Methods
    func getCars(completion: @escaping([Car]?, NetworkError?)->Void) {
        self.carService.getCarList() { [weak self] result in
            guard let self = self else { return }
            self.resetAttributes()
            switch (result) {
            case .success(let carList):
                carList.forEach { car in
                    var refinedCar = car
                    refinedCar.prosList = car.prosList.filter{!$0.isEmpty}
                    refinedCar.consList = car.consList.filter{!$0.isEmpty}
                    let section = Section(car: refinedCar)
                    self.sections.append(section)
                    self.originalSections.append(section)
                }
                completion(carList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func resetAttributes() {
        self.sections.removeAll()
        self.originalSections.removeAll()
    }
    
    func heightOfList(list: [String]) -> CGFloat {
        var height: CGFloat = Constants.titleRowHeight
        for text in list {
            let textheight = text.getHeightOfString()
            height += textheight+Constants.itemRowMargin
        }
        return height
    }
    
    func getFiltersData(for type: FilterType) -> [String] {
        let cars = self.originalSections.map({$0.car})
        switch type {
        case .make:
            return cars.map({$0.carBrand.rawValue})
        case .model:
            if let maker = self.selectedMake {
                return cars.filter({$0.carBrand.rawValue == maker}).map({$0.model})
            } else {
                return cars.map({$0.model})
            }
        }
        
    }
    
    func setFilter(for type: FilterType, selectedTitle: String?) {
        if type == .make {
            self.selectedMake = selectedTitle
            self.selectedModel = nil
        } else {
            self.selectedModel = selectedTitle
        }
        
        if let carMaker = self.selectedMake, let carModel = self.selectedModel {
            self.sections = self.originalSections.filter({$0.car.make == carMaker && $0.car.model == carModel})
        } else if let carMaker = self.selectedMake {
            self.sections = self.originalSections.filter({$0.car.make == carMaker})
        } else if let carModel = self.selectedModel {
            self.sections = self.originalSections.filter({$0.car.model == carModel})
        } else {
            self.sections = self.originalSections
        }
    }
}

// MARK: - Section
struct Section: Equatable {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.isOpened == rhs.isOpened
    }
    
    let car: Car
    var isOpened: Bool = false
}

// MARK: - Filter Type

enum FilterType: String {
    case make = "Make"
    case model = "Model"
}
