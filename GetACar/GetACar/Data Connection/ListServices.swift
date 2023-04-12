//
//  ListServices.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

protocol ListServices {
    var saveService: DataStorageService { get }
    func getCarList(completion: (Result<[Car], NetworkError>)->Void)
}

extension JsonFileReader: ListServices {
    
    var saveService: DataStorageService {
        return UserDataStorage()
    }
    
    /// getCarList will check for any stored data if its already find data then it will convert it to Car List Model else get it from the json file.
    func getCarList(completion: (Result<[Car], NetworkError>)->Void) {
        guard let savedJsonData = saveService.getStoreCarList() else {
            completion(self.getData(filename: "car_list", decode: [Car].self, save: saveService))
            return
        }
        do {
            let jsonResult = try JSONDecoder().decode([Car].self, from: savedJsonData)
            completion(.success(jsonResult))
        } catch {
            completion(.failure(.dataError(error.localizedDescription)))
        }
        
    }
}
