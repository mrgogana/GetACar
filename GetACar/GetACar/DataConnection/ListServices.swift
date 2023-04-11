//
//  ListServices.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation

protocol ListServices {
    func getCarList(completion: @escaping(Result<[Car], NetworkError>)->Void)
}

extension JsonFileReader: ListServices {
    func getCarList(completion: @escaping(Result<[Car], NetworkError>)->Void) {
        completion(self.getData(filename: "car_list", decode: [Car].self))
    }
}
