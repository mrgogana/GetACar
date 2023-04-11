//
//  String+Price.swift
//  GetACar
//
//  Created by Navpreet Gogana on 2023-04-11.
//

import Foundation

extension String {
    static func priceString(price: Double) -> String {
        let prefix = "Price: "
        var priceString = ""
        let thousand = price / 1000
        let million = price / 1000000
        if million >= 1.0 {
            priceString = "\(Int((million*10)/10))M"
        }
        else if thousand >= 1.0 {
            priceString = "\(Int((thousand*10)/10))K"
        }
        else {
            priceString = "\(price)"
        }
        return prefix+priceString
    }
}
