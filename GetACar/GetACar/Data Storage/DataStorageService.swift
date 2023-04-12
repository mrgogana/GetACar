//
//  DataStorageService.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-12.
//

import Foundation

protocol DataStorageService {
    var jsonKey: String { get }
    func storeCarList(jsonData: Data)
    func getStoreCarList()->Data?
}

extension UserDataStorage: DataStorageService {
    var jsonKey: String {
        return "CarKey"
    }
    
    func storeCarList(jsonData: Data) {
        self.storeData(data: jsonData, key: jsonKey)
    }
    
    func getStoreCarList()->Data? {
        self.getStoreData(forKey: jsonKey)
    }
}
