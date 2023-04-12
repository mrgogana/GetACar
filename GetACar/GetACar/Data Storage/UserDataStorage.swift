//
//  UserDataStorage.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-12.
//

import Foundation

class UserDataStorage {
    var userDefaults = UserDefaults.standard
    func storeData(data: Data, key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func getStoreData(forKey key:String) -> Data? {
        return userDefaults.data(forKey: key)
    }
}
