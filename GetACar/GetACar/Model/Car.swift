//
//  Car.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import Foundation


// MARK: - Car
struct Car: Decodable {
    var consList: [String]
    let customerPrice: Double
    let make: String
    let marketPrice: Double
    let model: String
    var prosList: [String]
    let rating: Int
    
    var carBrand: CarBrands {
        return CarBrands(rawValue: self.make) ?? .any
    }
    
    func carImageName()->String {
        
        switch (self.carBrand) {
        case .landRover:
            return "Range_Rover"
        case .bmw:
            return "BMW_330i"
        case .mercedes:
            return "Mercedez_benz_GLC"
        case .alpine:
            return "Alpine_roadster"
        case .any:
            return ""
        }
    }
}

enum CarBrands: String {
    case landRover = "Land Rover"
    case bmw = "BMW"
    case alpine = "Alpine"
    case mercedes = "Mercedes Benz"
    case any = "Any Make"
}
